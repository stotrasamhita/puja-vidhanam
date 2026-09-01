# पूजा-विधानम् (Puja Vidhanam)

A collection of Sanskrit mantras, śloka-s, and step-by-step ritual instructions (*vidhi*) for performing Hindu pūjā-s and vrata-s at home — set in LaTeX/Devanāgarī and compiled into ready-to-read PDF books.

Each puja chapter walks through the ritual in order — saṅkalpa (statement of intent, with blanks for the reciter to fill in the current tithi/nakṣatra/etc. from a pañcāṅga), āvāhana, the sixteen upacāra-s, and any puja-specific mantras — so the texts here can be followed directly during the ritual, not just read as reference.

## Just want the PDFs?

The compiled books are checked into the repo root, ready to download and use:

| File | What it is |
|---|---|
| [📄 `pujavidhanam.pdf`](https://github.com/stotrasamhita/puja-vidhanam/blob/master/pujavidhanam.pdf) | The main edition — compact page size (roughly A5), two-column layout, includes Vedic mantra portions, does not include the katha (story) chapters. |
| [📄 `pujavidhanam-kindle-scribe.pdf`](https://github.com/stotrasamhita/puja-vidhanam/blob/master/pujavidhanam-kindle-scribe.pdf) | Reflowed for the larger Kindle Scribe screen (three-column layout, bigger page), includes the katha chapters, but omits sections that consist purely of Vedic mantras (e.g. the Yajur Upākarma text). |
| [📄 `pujavidhanam-vaidika-kindle-scribe.pdf`](https://github.com/stotrasamhita/puja-vidhanam/blob/master/pujavidhanam-vaidika-kindle-scribe.pdf) | Same Kindle Scribe layout and katha chapters as above, but with the Vedic mantra portions included as well — the fuller ("vaidika") edition for readers who want those sections too. |

Each of these is produced from the same `pujas.tex`/`preamble.tex`/`shloka.sty` source; the differences are just a handful of LaTeX toggles (page geometry and whether Vedic-only and katha content is pulled in) — see [Building from source](#building-from-source).

If you only want a single puja rather than the whole book, `pujas-kindle-pdf/` and `pujas-kindle-scribe-pdf/` contain one self-contained PDF per puja (e.g. [📄 `ganga-puja-vidhanam.pdf`](https://github.com/stotrasamhita/puja-vidhanam/blob/master/pujas-kindle-pdf/ganga-puja-vidhanam.pdf)), in the two page sizes above, each generated from the matching file in `pujas/`.

## Repository layout

| Folder | Contents |
|---|---|
| [`pujas/`](pujas/) | One `.tex` file per puja/vrata — the main content of the book. See its own README for the list, grouped by type. |
| [`purvanga/`](purvanga/) | Shared preliminary rites (kalaśa-pūjā, ghaṇṭā-pūjā, navagraha-pūjā, etc.) that many pujas in `pujas/` pull in via `\input`, rather than repeating. |
| [`kathas/`](kathas/) | The mythological stories (*kathā*/*māhātmya*) traditionally recited alongside particular vratas — organized by occasion, and often by source Purāṇa within that. |
| [`appendices/`](appendices/) | Reference lists used throughout the sankalpa (names of saṁvatsara-s, māsa-s, nakṣatra-s, yoga-s, karaṇa-s). |
| `pujas-kindle-pdf/`, `pujas-kindle-scribe-pdf/` | Per-puja standalone PDFs (see above) plus the small LaTeX template/footer/build-script used to generate them from `pujas/`. |

Shared infrastructure at the root:

- `preamble.tex` — packages, page-header/footer setup, the info-box/callout macros (`\pujainfobox`, `\pujanote`, `\instruct`), and the reusable `\sankalpa` block with its fill-in-the-blank commands (`\samvatsara`, `\tithau`, `\nakshatra`, ...).
- `shloka.sty` — the custom style package that lays out verses (`\twolineshloka`, `\threelineshloka`, ...), section/chapter headings, and the table of contents.
- `frontmatter.tex` — title page, colophon, and table of contents, `\input` at the start of every edition.
- `purana-dhyana-shloka.tex` — dhyāna-śloka-s for various deities, `\input` by `preamble.tex`.
- `pujas.tex` — the master file that `\input`s every individual puja from `pujas/` and every table from `appendices/`, in the order and grouping used for the compiled book. This is the single place to look to see how the whole book is assembled.
- `pujavidhanam.tex` / `pujavidhanam-kindle-scribe.tex` / `pujavidhanam-vaidika-kindle-scribe.tex` — the three top-level documents that produce the three PDFs above; each just sets page geometry and a few boolean toggles, then `\input{frontmatter}` and `\input{pujas}`.

## Building from source

The texts are typeset with **XeLaTeX** (see the `% !TeX program = XeLaTeX` line at the top of each root `.tex` file), needed because the documents mix Devanāgarī with Latin text and use `fontspec`-based font selection throughout.

Requirements:

- A TeX distribution with XeLaTeX and `latexmk` (e.g. TeX Live or MacTeX). Packages used include `fontspec`, `xunicode`/`xltxtra`, `etoolbox`, `tcolorbox`, `fancyhdr`, `hyperref`, `enumitem`, `tocloft`, `titlesec`, `multicol`, `supertabular`/`longtable`, `pdfpages`, and `fontawesome` — a full TeX Live install has all of these.
- The Devanāgarī and Latin fonts referenced by name via `fontspec` — none are bundled in this repo, so they need to be installed on your system separately: **Siddhanta**, **Sanskrit 2003**, **Adishila Heavy**, **Noto Sans** (regular and bold), and **Candara**.

To build the main edition:

```sh
xelatex pujavidhanam.tex
xelatex pujavidhanam.tex   # run twice for the table of contents / cross-references
```

The other two editions build the same way from `pujavidhanam-kindle-scribe.tex` / `pujavidhanam-vaidika-kindle-scribe.tex`.

Each top-level `.tex` file sets a few `etoolbox` booleans near the top that control what gets included — this is how the three editions above differ:

- `kindle` — page geometry (compact single-book size vs. the larger Kindle Scribe size).
- `veda` — whether Vedic-mantra-only sections (guarded with `\ifbool{veda}{...}{}` in `pujas.tex`, e.g. Yajur Upākarma) are included.
- `katha` — whether the katha/māhātmya chapters are pulled in.
- `individual` — set true only when compiling a single puja standalone (see `pujas-kindle-pdf/puja-kindle-template.tex`); it suppresses cross-references to pages elsewhere in the full book.

To rebuild the per-puja booklets in `pujas-kindle-pdf/` or `pujas-kindle-scribe-pdf/`, run the `tex2pdf.sh` script inside either folder — it concatenates that folder's template + footer around each `pujas/*.tex` file (skipping `old/`, and the include-only `MahaNyasah.tex`/`rudra-prashnah.tex`/`ekadashi.tex` files) and compiles each with `latexmk -xelatex`.

### Transliteration script

`kathas/trans.py` converts a Devanāgarī `.tex` source into the equivalent files in Tamil, Telugu, Grantha, Kannada, Malayalam, Bengali, Oriya, Śāradā, Gujarati, and IAST/romanized (Hindi) script, rewriting the LaTeX macros and font toggles to match. It depends on an external `xsanscript` transliteration module that isn't vendored in this repo.

## Contributing

New pujas, corrections to existing mantras/vidhi, or additional kathas are welcome as pull requests — please follow the structure and macros already used in a neighboring file in the same folder (`\sankalpa`, `\instruct`, `\twolineshloka`/`\threelineshloka`, etc.) rather than introducing new formatting patterns. If you're adding a full new puja, remember to add an `\input` line for it in `pujas.tex` under the appropriate part.

## License / usage

Per the colophon in `frontmatter.tex`: these texts are compiled **for personal use only, not for commercial printing or distribution**. See [stotrasamhita.github.io/about](http://stotrasamhita.github.io/about/) for more on the project and its sources.

## Acknowledgements

Typeset using several LaTeX macros originally designed by H. L. Prasād; much of the Devanāgarī encoding was done with Ajit Krishnan's Mudgala IME. Thanks to [archive.org](https://archive.org) for hosting and providing access to numerous source texts.

---

*The README.md files on this repo were generated and beautified with Claude.*
