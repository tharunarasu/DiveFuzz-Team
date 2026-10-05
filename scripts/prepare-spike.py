"""Repair Windows checkout details needed by the Linux build, within F:."""
from pathlib import Path

spike = Path(__file__).resolve().parents[1] / "ref/riscv-isa-sim-adapter"
for relative in ("configure", "config.h.in", "scripts/config.guess", "scripts/config.sub",
                 "scripts/install-sh", "scripts/vcs-version.sh", "scripts/mk-install-dirs.sh"):
    path = spike / relative
    data = path.read_bytes()
    if b"\r\n" in data:
        path.write_bytes(data.replace(b"\r\n", b"\n"))
        print("Normalized:", relative)
link = spike / "spike_dasm/spike_dasm_option_parser.cc"
target = "../fesvr/option_parser.cc"
if not link.is_symlink():
    if link.read_text().strip() != target:
        raise RuntimeError("Unexpected contents; refusing to replace " + str(link))
    assert (link.parent / target).resolve().is_relative_to(spike.resolve())
    link.unlink()
    link.symlink_to(target)
    print("Restored Git symlink:", link)
