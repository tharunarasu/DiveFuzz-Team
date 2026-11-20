"""Functional regression checks for error propagation and generator configuration."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'fuzzer'))
from generator.config.cli_parser import create_parser
from generator.config.config_manager import setup_config
from generator.asm_template_manager.ext_list import allowed_ext
from utils.elf_to_img import process_file

class FunctionalChecks(unittest.TestCase):
    def test_integer_profile_and_explicit_exclusions(self):
        args = create_parser().parse_args(['--generate', '--allowed-ext-name', 'nutshell',
            '--template-type', 'nutshell', '--architecture', 'nutshell', '--random-seed', '501',
            '--allow-duplicates', '--exclude-ext', 'RV_ZICSR', '--exclude-opcodes', 'ecall', 'ebreak'])
        config = setup_config(args)
        self.assertEqual(config.isa, 'rv64imc_zicsr_zifencei')
        self.assertNotIn('RV_ZICSR', allowed_ext.allowed_ext)
        self.assertEqual(config.random_seed, 501)
        self.assertTrue(config.allow_duplicates)
        self.assertEqual(config.exclude_opcodes, ['ecall', 'ebreak'])

    def test_invalid_assembly_is_an_error(self):
        with tempfile.TemporaryDirectory(dir=ROOT / '.local/tmp') as folder:
            path = Path(folder)
            (path / 'bad.S').write_text('this_is_not_a_riscv_instruction\n')
            (path / 'img').mkdir()
            (path / 'elf').mkdir()
            with self.assertRaises(subprocess.CalledProcessError):
                process_file('bad.S', folder, str(path / 'img'), str(path / 'elf'))
            self.assertFalse((path / 'img/bad.img').exists())

    def test_runner_process_reports_failure(self):
        with tempfile.TemporaryDirectory(dir=ROOT / '.local/tmp') as folder:
            path = Path(folder)
            seed = path / 'dummy.img'
            seed.write_bytes(b'fixture')
            for program, expected in [('/bin/true', 0), ('/bin/false', 1)]:
                config = dict(dut_target=[dict(name='exit-status-regression', threads=1,
                    version='fixture', diff_ref='None', emu_path=str(path), cmd=program+' $1')],
                    seeds=[dict(name='fixture', path=str(seed))])
                cfg = path / 'config.json'
                cfg.write_text(json.dumps(config))  # JSON is also valid YAML.
                p = subprocess.run([sys.executable, str(ROOT / 'fuzzer/run_dut.py'), '--config', str(cfg)],
                                   cwd=path, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, timeout=60)
                self.assertEqual(p.returncode, expected, p.stdout)

if __name__ == '__main__':
    unittest.main(verbosity=2)
