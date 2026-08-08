#!/bin/bash
# Splits ekadashi-mahatmyam-padma-puranam.tex into one .tex file per chapter
# under chapters/, named "<chapter-number>-<slug>.tex" (e.g. 56-kamika.tex).
#
# The chapter number is read from the \dnsub{...अध्यायः॥<devanagari-num>}
# marker in each chapter, and the slug from the last hyphen-separated part
# of the chapter's \label{sec:padma-...}.
#
# ekadashi-mahatmyam-padma-puranam.tex remains the single source of truth
# (for find-and-replace, proofreading, etc). Files under chapters/ are
# generated output: re-run this script after editing the master file to
# regenerate them; do not hand-edit files in chapters/.

set -euo pipefail
cd "$(dirname "$0")"

python3 - <<'PYEOF'
import os
import re
import sys

SRC = "ekadashi-mahatmyam-padma-puranam.tex"
OUTDIR = "chapters"

DEVANAGARI_DIGITS = "०१२३४५६७८९"
LABEL_RE = re.compile(r"\\label\{sec:padma-([^}]+)\}")
DNSUB_RE = re.compile(r"॥([" + DEVANAGARI_DIGITS + r"]+)\}")


def devanagari_to_int(digits):
    return int("".join(str(DEVANAGARI_DIGITS.index(ch)) for ch in digits))


def slug_from_label(label):
    last = label.strip().split("-")[-1]
    last = last.split()[0]  # guard against stray spaces, e.g. a typo'd label
    return re.sub(r"[^a-z0-9]+", "", last.lower())


with open(SRC, encoding="utf-8") as f:
    lines = f.readlines()

sect_idxs = [i for i, line in enumerate(lines) if line.startswith("\\sect{")]
if not sect_idxs:
    sys.exit(f"No \\sect{{...}} markers found in {SRC}")

os.makedirs(OUTDIR, exist_ok=True)
for fn in os.listdir(OUTDIR):
    if fn.endswith(".tex"):
        os.remove(os.path.join(OUTDIR, fn))

chapters = []
for n, start in enumerate(sect_idxs):
    end = sect_idxs[n + 1] if n + 1 < len(sect_idxs) else len(lines)
    block = lines[start:end]

    label = None
    chapter_num = None
    for line in block:
        if label is None:
            m = LABEL_RE.search(line)
            if m:
                label = m.group(1)
        if chapter_num is None:
            m = DNSUB_RE.search(line)
            if m:
                chapter_num = devanagari_to_int(m.group(1))
        if label and chapter_num:
            break

    if not label:
        sys.exit(f"No \\label{{sec:padma-...}} found for chapter starting at line {start + 1}")
    if not chapter_num:
        sys.exit(f"No chapter number (\\dnsub{{...अध्यायः॥<num>}}) found for chapter starting at line {start + 1}")

    chapters.append((chapter_num, slug_from_label(label), start + 1, end, block))

seen = {}
for chapter_num, slug, start, end, block in chapters:
    if chapter_num in seen:
        sys.exit(f"Duplicate chapter number {chapter_num} (lines {start}-{end} and {seen[chapter_num]})")
    seen[chapter_num] = f"lines {start}-{end}"

chapters.sort(key=lambda c: c[0])

for chapter_num, slug, start, end, block in chapters:
    fname = f"{chapter_num}-{slug}.tex"
    with open(os.path.join(OUTDIR, fname), "w", encoding="utf-8") as out:
        out.writelines(block)
    print(f"{fname}\t(lines {start}-{end} of {SRC})")

print(f"\n{len(chapters)} chapters written to {OUTDIR}/")
PYEOF
