#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-final-f.sh"
checks="$DIVEFUZZ_ROOT/evidence/final/checks"
mkdir -p "$checks"
corpus="$checks/runner-corpus"
mkdir -p "$corpus"
cd "$DIVEFUZZ_ROOT/fuzzer"
python -m generator.main --generate --eliminate --architecture nutshell --allowed-ext-name nutshell --template-type nutshell --random-seed 501 --max-workers 1 --seeds 1 --instr-number 20 --no-jump --exclude-ext RV_ZICSR --exclude-opcodes ecall ebreak --out-dir "$corpus"
seed="$corpus/seeds_0_.img"
riscv64-unknown-elf-as -march=rv64imc_zicsr_zifencei "$corpus/seeds_0_.S" -o "$corpus/seeds_0_.o"
riscv64-unknown-elf-ld -T "$DIVEFUZZ_ROOT/fuzzer/generator/reg_analyzer/linker/link.ld" "$corpus/seeds_0_.o" -o "$corpus/seeds_0_.elf"
riscv64-unknown-elf-objcopy -O binary "$corpus/seeds_0_.elf" "$seed"
cat > "$checks/runner-nutshell.json" <<EOF
{"dut_target":[{"name":"NutShell","threads":1,"version":"63a2687","diff_ref":"NEMU","emu_path":"$NOOP_HOME","cmd":"./build/emu -i \$1 --diff $NOOP_HOME/ready-to-run/riscv64-nemu-interpreter-so -C 200000 -b 0 -e 0"}],"seeds":[{"name":"rtl-pilot","path":"$seed"}]}
EOF
cd "$DIVEFUZZ_ROOT/fuzzer"
python run_dut.py --config "$checks/runner-nutshell.json" 2>&1 | tee "$checks/runner-nutshell.log"
