# kathas/ekadashi/padma-puranam/

- `ekadashi-mahatmyam-padma-puranam.tex` — the master file: the Padma Purāṇa's full Ekādaśī-māhātmya, Śiva narrating each named Ekādaśī's vrata and glory to Pārvatī in turn. This is the single source of truth for editing/proofreading.
- `chapters/` — the same text auto-split into one file per Ekādaśī; see that folder's README.
- `splitChapters.sh` — regenerates `chapters/` from the master file (reads each chapter's number and name from its `\dnsub{...अध्यायः॥<num>}` marker and `\label{sec:padma-...}`). Re-run after editing the master; never hand-edit files under `chapters/`.
