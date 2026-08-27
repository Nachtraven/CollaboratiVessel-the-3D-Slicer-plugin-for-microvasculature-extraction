import pandas as pd
import math
import glob, os
import argparse


"""
Panoptic quality computation from CSV vessel stats
NOTE: An assumption is made here because of the basis in the csv - 
overlap_voxels are not per unit, but aglomerated due to the creation of the csv
not being vessel level aware.
This bias affects both thresholding and the pipeline and we ignore it.
"""
def compute_pq(csv_path, pred_method, pred_variant,
               gt_method="ground_truth", gt_variant="",
               iou_threshold=0.5):
    df = pd.read_csv(csv_path, dtype={"corresponding_ids": str, "variant": str})
    df["variant"] = df["variant"].fillna("")
    df["corresponding_ids"] = df["corresponding_ids"].fillna("")

    def filt(m, v):
        return df[(df["method"] == m) & (df["variant"] == v)].copy()

    gt   = filt(gt_method,   gt_variant)
    pred = filt(pred_method, pred_variant)

    gt_vol = dict(zip(gt["vessel_id"].astype(int), gt["volume_voxels"].astype(float)))

    iou_sum = 0.0
    tp, fp, fn = 0, 0, 0
    matched_gt = set()

    for _, row in pred.iterrows():
        ids = [int(x) for x in str(row["corresponding_ids"]).split(";")
               if x.strip()]
        if not ids:
            fp += 1
            continue

        # Find the best-IoU GT match among all corresponding ids
        best_iou, best_gid = 0.0, None
        pv = float(row["volume_voxels"])
        ov = float(row["overlap_voxels"])

        for gid in ids:
            gv = gt_vol.get(gid, 0.0)
            iou = ov / (pv + gv - ov) if (pv + gv - ov) > 0 else 0.0
            if iou > best_iou:
                best_iou, best_gid = iou, gid

        if best_iou >= iou_threshold:
            tp += 1
            iou_sum += best_iou
            matched_gt.add(best_gid)
        else:
            fp += 1

    fn = len(gt) - len(matched_gt)

    sq = iou_sum / tp if tp > 0 else 0.0
    rq = tp / (tp + 0.5 * fp + 0.5 * fn) if (tp + fp + fn) > 0 else 0.0
    pq = sq * rq

    return dict(PQ=round(pq, 4), SQ=round(sq, 4), RQ=round(rq, 4),
                TP=tp, FP=fp, FN=fn)


# ── CLI ───────────────────────────────────────────────────────────────────────

"""
python template/sections/appendices/bipartite/panoptic_quality.py \
  resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv
"""

if __name__ == "__main__":
    
    p = argparse.ArgumentParser()
    p.add_argument("csv",                           help="VESSELS_*.csv path")
    a = p.parse_args()
    pipe = compute_pq(a.csv, "pipeline", "default")
    thr  = compute_pq(a.csv, "threshold", "best_dice")
    
    print(f"  Pipeline:     PQ={pipe['PQ']}  SQ={pipe['SQ']}  RQ={pipe['RQ']}")
    print(f"  Thresholding: PQ={thr['PQ']}  SQ={thr['SQ']}  RQ={thr['RQ']}")

