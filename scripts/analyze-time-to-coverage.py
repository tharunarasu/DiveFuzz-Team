"""Compute a reproducible time-to-coverage curve from a completed campaign.

The campaign already records per-seed RTL wall time, compilation time, and a
Verilator coverage dump for every seed.  This script unions covered NutCore
line points in the same seed order used by the campaign and reports the time
needed to reach one common fraction of the final line-coverage budget.
"""
import argparse
import csv
import json
import math
from pathlib import Path
import subprocess


ROOT = Path(__file__).resolve().parents[1]


def coverage_keys(path: Path, metric: str = "line"):
    """Return covered NutCore coverage-point keys from one SystemC dump."""
    covered = set()
    prefix = f"v_{metric}/"
    # Coverage dumps contain all toggle points and are several gigabytes for
    # the full campaign.  ripgrep scans them in native code and returns only
    # the much smaller line-coverage subset; the Python fallback keeps the
    # script portable if ripgrep is unavailable.
    try:
        result = subprocess.run(
            ["rg", "-a", "--no-filename", f"page.*{prefix}", str(path)],
            capture_output=True, text=True, errors="replace", check=False,
        )
        lines = result.stdout.splitlines()
    except (FileNotFoundError, OSError):
        lines = path.read_text(errors="replace").splitlines()
    for line in lines:
        if not line.startswith("C '"):
            continue
        try:
            key, count_text = line[3:].rsplit("' ", 1)
            count = int(count_text)
        except (ValueError, IndexError):
            continue
        if count <= 0:
            continue
        fields = {
            part.split("\x02", 1)[0]: part.split("\x02", 1)[1]
            for part in key.split("\x01")
            if "\x02" in part
        }
        page = fields.get("page", "")
        hierarchy = fields.get("h", "")
        if not page.startswith(prefix):
            continue
        if "TOP.SimTop.soc.nutcore" not in hierarchy:
            continue
        if any(label in page for label in ("DPICWrapper", "DiffWrapper")):
            continue
        covered.add(key)
    return covered


def load_campaign(path: Path):
    return json.loads((path / "results.json").read_text())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--campaign", type=Path, default=None,
                        help="Campaign directory; defaults to latest-campaign.txt")
    parser.add_argument("--fraction", type=float, default=0.80,
                        help="Fraction of the common final coverage budget (default: 0.80)")
    parser.add_argument("--metric", choices=("line", "branch", "toggle"), default="branch",
                        help="Coverage family to track (default: branch; line saturates during boot)")
    args = parser.parse_args()
    if not 0 < args.fraction <= 1:
        raise SystemExit("--fraction must be in (0, 1]")

    campaign = args.campaign
    if campaign is None:
        campaign = ROOT / Path((ROOT / "evidence/final/latest-campaign.txt").read_text().strip())
    if not campaign.is_absolute():
        campaign = ROOT / campaign
    data = load_campaign(campaign)
    runs = []
    final_sets = []
    per_run_sets = {}
    for run in data["runs"]:
        seed_sets = []
        for seed in run["seeds"]:
            files = [ROOT / p for p in seed.get("coverage_files", [])]
            points = set()
            for path in files:
                points.update(coverage_keys(path, args.metric))
            seed_sets.append(points)
        final = set().union(*seed_sets) if seed_sets else set()
        per_run_sets[id(run)] = seed_sets
        final_sets.append(final)
    common_final = min((len(x) for x in final_sets), default=0)
    target = math.ceil(common_final * args.fraction)

    for run, final in zip(data["runs"], final_sets):
        seed_sets = per_run_sets[id(run)]
        covered = set()
        rtl_elapsed = 0.0
        e2e_elapsed = float(run["generation"]["seconds"])
        points = []
        first = None
        for index, (seed, seed_points) in enumerate(zip(run["seeds"], seed_sets), start=1):
            compile_seconds = sum(x.get("seconds", 0.0) for x in seed.get("compilation", []))
            rtl_seconds = seed.get("rtl", {}).get("seconds", 0.0)
            rtl_elapsed += rtl_seconds
            e2e_elapsed += compile_seconds + rtl_seconds
            covered.update(seed_points)
            item = {
                "seed_index": index,
                "seed_name": seed["name"],
                "covered_points": len(covered),
                "final_points": len(final),
                "percent_of_run_final": round(100 * len(covered) / len(final), 4)
                if final else 0.0,
                "accepted_instructions": index * data["parameters"]["instructions"],
                "rtl_seconds_since_first_seed": round(rtl_elapsed, 4),
                "end_to_end_seconds": round(e2e_elapsed, 4),
            }
            points.append(item)
            if first is None and len(covered) >= target:
                first = item.copy()
        run_result = {
            "repeat": run["repeat"],
            "mode": run["mode"],
            "rng_seed": run["rng_seed"],
            "target_fraction": args.fraction,
            "common_final_coverage_points": common_final,
            "target_coverage_points": target,
            "run_final_coverage_points": len(final),
            "time_to_target_rtl_seconds": first["rtl_seconds_since_first_seed"] if first else None,
            "time_to_target_end_to_end_seconds": first["end_to_end_seconds"] if first else None,
            "seeds_to_target": first["seed_index"] if first else None,
            "instructions_to_target": first["accepted_instructions"] if first else None,
            "curve": points,
        }
        runs.append(run_result)

    destination = ROOT / "evidence/final/time-to-coverage" / args.metric
    destination.mkdir(parents=True, exist_ok=True)
    summary = {
        "campaign": str(campaign.relative_to(ROOT)),
        "metric": f"NutCore Verilator {args.metric} coverage",
        "seed_order": "campaign execution order (lexicographic source order)",
        "fraction_of_common_final": args.fraction,
        "common_final_coverage_points": common_final,
        "target_coverage_points": target,
        "runs": runs,
    }
    (destination / "summary.json").write_text(json.dumps(summary, indent=2))
    with (destination / "summary.csv").open("w", newline="") as stream:
        fields = ["repeat", "mode", "rng_seed", "common_final_coverage_points",
                  "target_coverage_points", "run_final_coverage_points",
                  "time_to_target_rtl_seconds", "time_to_target_end_to_end_seconds",
                  "seeds_to_target", "instructions_to_target"]
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows({field: row[field] for field in fields} for row in runs)
    with (destination / "curve.csv").open("w", newline="") as stream:
        fields = ["repeat", "mode", "rng_seed", "seed_index", "seed_name",
                  "covered_points", "final_points", "percent_of_run_final",
                  "accepted_instructions", "rtl_seconds_since_first_seed",
                  "end_to_end_seconds"]
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        for row in runs:
            for point in row["curve"]:
                writer.writerow({"repeat": row["repeat"], "mode": row["mode"],
                                 "rng_seed": row["rng_seed"], **point})
    (ROOT / "evidence/final/latest-time-to-coverage.txt").write_text(
        str(destination.relative_to(ROOT))
    )
    print(json.dumps({
        "output": str(destination.relative_to(ROOT)),
        "target_coverage_points": target,
        "runs": [{k: r[k] for k in ("repeat", "mode", "time_to_target_rtl_seconds",
                                    "time_to_target_end_to_end_seconds", "seeds_to_target")}
                 for r in runs],
    }, indent=2))


if __name__ == "__main__":
    main()
