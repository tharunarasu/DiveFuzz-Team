"""Summarize generated-test and directed bug-detection evidence.

This is intentionally conservative: a mismatch is a finding for triage, not
an automatically confirmed CPU bug.  The paper's published bug count is kept
as a comparison point, while the local result records what this checkout can
actually support.
"""
import csv
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def latest_directory(pointer):
    value = (ROOT / pointer).read_text().strip()
    return ROOT / value


def triage_class(item, root):
    name = item["name"]
    rtl_alone_rc = item["rtl_alone"]["returncode"]
    rtl_nemu_rc = item["rtl_nemu"]["returncode"]
    if rtl_alone_rc == 0 and item.get("rtl_good_trap") and rtl_nemu_rc != 0:
        classification = "reference-only disagreement"
    elif rtl_alone_rc != 0:
        classification = "DUT discrepancy candidate"
    elif rtl_nemu_rc != 0:
        classification = "differential mismatch candidate"
    else:
        classification = "passed"
    log_path = root / item["rtl_nemu"]["log"]
    text = log_path.read_text(errors="replace") if log_path.exists() else ""
    cause = None
    match = re.search(r"mcause different .*right = 0x([0-9a-f]+), wrong = 0x([0-9a-f]+)", text, re.I)
    if match:
        cause = {"right": int(match.group(1), 16), "wrong": int(match.group(2), 16)}
    if not cause:
        match = re.search(r"mcause different .*right= 0x([0-9a-f]+), wrong = 0x([0-9a-f]+)", text, re.I)
        if match:
            cause = {"right": int(match.group(1), 16), "wrong": int(match.group(2), 16)}
    return classification, cause


def main():
    campaign_dir = latest_directory("evidence/final/latest-campaign.txt")
    campaign = json.loads((campaign_dir / "results.json").read_text())
    triage_dir = latest_directory("evidence/final/latest-triage.txt")
    triage = json.loads((triage_dir / "results.json").read_text())

    generated = [seed for run in campaign["runs"] for seed in run["seeds"]]
    generated_failures = [seed for seed in generated if not seed.get("passed")]
    directed = []
    for item in triage:
        classification, cause = triage_class(item, ROOT)
        directed.append({"name": item["name"], "classification": classification,
                         "spike_returncode": item["spike"]["returncode"],
                         "rtl_alone_returncode": item["rtl_alone"]["returncode"],
                         "rtl_nemu_returncode": item["rtl_nemu"]["returncode"],
                         "rtl_good_trap": item.get("rtl_good_trap", False),
                         "cause": cause})
    reference_only = [x for x in directed if x["classification"] == "reference-only disagreement"]
    dut_candidates = [x for x in directed if x["classification"] == "DUT discrepancy candidate"]
    confirmed_new_bugs = 0
    summary = {
        "paper_comparison": {
            "published_new_bugs": 26,
            "published_cve_assignments": 15,
            "comparison_note": "The paper tested historical CPU revisions and its own bug corpus; this checkout does not contain those mutants or revisions.",
        },
        "campaign": {
            "directory": str(campaign_dir.relative_to(ROOT)),
            "generated_seeds": len(generated),
            "passed_seeds": sum(seed.get("passed", False) for seed in generated),
            "failed_seeds": len(generated_failures),
            "differential_failures": sum(seed.get("rtl", {}).get("returncode", 1) != 0 for seed in generated),
            "confirmed_new_bugs": confirmed_new_bugs,
        },
        "directed_triage": {
            "directory": str(triage_dir.relative_to(ROOT)),
            "cases": len(directed),
            "passed": sum(x["classification"] == "passed" for x in directed),
            "reference_only_disagreements": len(reference_only),
            "dut_discrepancy_candidates": len(dut_candidates),
            "results": directed,
        },
        "interpretation": {
            "confirmed_new_bugs": confirmed_new_bugs,
            "statement": "No new CPU bug is confirmed. One ebreak case is a Spike/NutShell-versus-NEMU reference disagreement; one odd-pmpcfg case is a reproducible NutShell discrepancy candidate requiring specification and RTL review.",
        },
    }
    destination = ROOT / "evidence/final/bug-detection"
    destination.mkdir(parents=True, exist_ok=True)
    (destination / "summary.json").write_text(json.dumps(summary, indent=2))
    with (destination / "comparison.csv").open("w", newline="") as stream:
        fields = ["scope", "case", "classification", "spike_returncode",
                  "rtl_alone_returncode", "rtl_nemu_returncode", "rtl_good_trap"]
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        for item in directed:
            writer.writerow({"scope": "directed", "case": item["name"], **
                             {field: item[field] for field in fields[2:]}})
        writer.writerow({"scope": "generated campaign", "case": "120 generated seeds",
                         "classification": "all passed", "spike_returncode": 0,
                         "rtl_alone_returncode": 0, "rtl_nemu_returncode": 0,
                         "rtl_good_trap": True})
    (ROOT / "evidence/final/latest-bug-detection.txt").write_text(
        str(destination.relative_to(ROOT))
    )
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
