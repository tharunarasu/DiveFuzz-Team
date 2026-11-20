"""Apply narrowly scoped, reproducible host-compatibility fixes to pinned RTL harness."""
from pathlib import Path

root = Path(__file__).resolve().parents[1]
emu = root / 'dut/NutShell/difftest/src/test/csrc/verilator/emu.cpp'
data = emu.read_text()
old, new = '"%F@%T"', '"%F@%H-%M-%S"'
if old in data:
    emu.write_text(data.replace(old, new))
    print('Changed coverage/snapshot timestamp filenames to work on Windows F:')
elif new not in data:
    raise RuntimeError('Unexpected timestamp implementation; refusing to patch')
