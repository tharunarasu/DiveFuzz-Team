"""Record reproducible environment and small generator checks; no RTL claims."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

root = Path(__file__).resolve().parents[1]
evidence = root / "evidence"
evidence.mkdir(exist_ok=True)
checks = []

def run(name, command, cwd=root, timeout=180):
    started = time.perf_counter()
    try:
        result = subprocess.run(command, cwd=cwd, text=True, stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT, timeout=timeout)
        code, output = result.returncode, result.stdout
    except subprocess.TimeoutExpired as exc:
        code = 124
        output = str(exc)
    (evidence / f"{name}.log").write_text(output)
    check = dict(name=name, command=command, returncode=code,
                 seconds=round(time.perf_counter()-started, 3))
    checks.append(check)
    print(json.dumps(check), flush=True)
    return code

run("platform", ["uname", "-a"])
run("python-packages", [sys.executable, "-m", "pip", "freeze"])
run("pip-check", [sys.executable, "-m", "pip", "check"])
run("compiler", ["riscv64-unknown-elf-gcc", "--version"])
run("assembler", ["riscv64-unknown-elf-as", "--version"])
run("submodules", ["git", "submodule", "status"])
run("commit", ["git", "rev-parse", "HEAD"])
engine = root / "ref/riscv-isa-sim-adapter/spike_engine"
run("engine-import", [sys.executable, "-c",
    f"import sys; sys.path.insert(0, {str(engine)!r}); import spike_engine; print(spike_engine.__file__)"])
sanity = evidence / "reference-sanity.S"
sanity.write_text('''\
.section .text
.globl _start
_start:
    li t0, 40
    addi t0, t0, 2
    li t2, 42
    bne t0, t2, fail
    li t0, 1
    j finish
fail:
    li t0, 3
finish:
    la t1, tohost
    sd t0, 0(t1)
1:  j 1b
.section .tohost,"aw",@progbits
.balign 64
.globl tohost
tohost: .dword 0
.balign 64
.globl fromhost
fromhost: .dword 0
''')
if run("reference-assemble", ["riscv64-unknown-elf-as", "-march=rv64gc", str(sanity),
                              "-o", str(sanity.with_suffix(".o"))]) == 0:
    if run("reference-link", ["riscv64-unknown-elf-ld", "-T", str(root / "scripts/reference-sanity.ld"),
          str(sanity.with_suffix(".o")), "-o", str(sanity.with_suffix(".elf"))]) == 0:
        run("reference-execute", [os.environ["spike"], "--isa=rv64gc",
                                  str(sanity.with_suffix(".elf"))], timeout=30)
run("generator-help", [sys.executable, "-m", "generator.main", "--help"], root / "fuzzer")
out = evidence / ("seeds-" + time.strftime("%Y%m%d-%H%M%S"))
code = run("generator-smoke", [sys.executable, "-m", "generator.main", "--generate",
    "--eliminate", "--architecture", "cva6", "--allowed-ext-name", "cva6",
    "--template-type", "cva6", "--seeds", "2", "--instr-number", "20",
    "--max-workers", "1", "--no-jump", "--debug", "--debug-mode", "SUMMARY",
    "--out-dir", str(out)], root / "fuzzer", timeout=180)
sources = list(out.glob("*.S"))
artifacts = []
isa_file = out / ".isa_info"
isa = next((line.split("=", 1)[1] for line in isa_file.read_text().splitlines()
            if line.startswith("ISA=")), "") if isa_file.exists() else ""
for source in sources:
    obj, elf, img = source.with_suffix(".o"), source.with_suffix(".elf"), source.with_suffix(".img")
    stem = source.stem
    if run(stem+"-assemble", ["riscv64-unknown-elf-as", "-march="+isa, str(source), "-o", str(obj)]) == 0:
        if run(stem+"-link", ["riscv64-unknown-elf-ld", "-T",
            str(root / "fuzzer/generator/reg_analyzer/linker/link.ld"), str(obj), "-o", str(elf)]) == 0:
            run(stem+"-image", ["riscv64-unknown-elf-objcopy", "-O", "binary", str(elf), str(img)])
            run(stem+"-elf-header", ["riscv64-unknown-elf-readelf", "-h", str(elf)])
    for path in (source, elf, img):
        if path.exists():
            artifacts.append(dict(path=str(path.relative_to(root)), bytes=path.stat().st_size,
                                  sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
summary = dict(checks=checks, requested_seeds=2, requested_instructions_per_seed=20,
               generated_sources=len(sources), isa=isa, artifacts=artifacts,
               storage_root=str(root), dut_executed=False,
               smoke_passed=code == 0 and len(sources) == 2 and
               len(list(out.glob("*.img"))) == 2 and
               all(p.stat().st_size > 0 for p in out.glob("*.img")) and
               all(c["returncode"] == 0 for c in checks))
(evidence / "verification.json").write_text(json.dumps(summary, indent=2))
print(json.dumps(summary, indent=2))
sys.exit(0 if summary["smoke_passed"] else 1)
