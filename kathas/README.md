# kathas/

The *kathā*-s and *māhātmya*-s (mythological stories, and accounts of a place/time/observance's glory) traditionally recited alongside particular vratas and pujas — a Śivarātri vrata katha, an Ekādaśī māhātmya, and so on.

## Structure

Shorter, single-file stories sit directly in this folder, e.g.:

- `pradosha-katha.tex`, `somavara-vrata-katha.tex`, `sankashta-chaturthi-vrata-katha.tex`, `siddhivinayaka-vrata-katha.tex`, `pativrata-mahatyma-parva.tex`, `syamantakopakhyanam.tex`

Occasions with more material — multiple tellings, or a story spanning many chapters — get their own subfolder, one per occasion:

- `chaturthi/`, `ekadashi/`, `janmashtami/`, `kartika-mahatymam/`, `margashirsha-mahatmyam/`, `nrisimha-jayanti/`, `shankara-jayanti/`, `shivaratri/`, `shravana-mahatmyam/`, `sriramanavami/`, `vaishakha-mahatmyam/`, `varalakshmi-vratam/`

Within one of these, where a version of the story is drawn from a particular source Purāṇa, it typically gets a further subfolder named for that source, e.g. `chaturthi/mudgala-puranam/`, `ekadashi/padma-puranam/`, `ekadashi/vrata-raja/`. A few occasion folders instead hold a long text split into numbered chapter files (`kartika-mahatymam/src/001.md`, `002.md`, ... or `ekadashi/padma-puranam/chapters/37-unmilani.tex`, `38-pakshavardhini.tex`, ...) alongside the assembled `.tex` file that pulls them together — `kartika-mahatymam/src/` in particular also keeps the original plain-text/Markdown source the `.tex` was transcribed from.

Multiple stories can exist for the same occasion (e.g. both `nrisimha-jayanti/bhagavatam-07-08.tex`/`bhagavatam-07-09.tex` and `nrisimha-jayanti/nrisimha-jayanti-vrata-katha.tex`) where more than one traditional telling is included.

## Scripts

- `trans.py` — transliterates a Devanāgarī `.tex` file in this tree into ten other scripts (Tamil, Telugu, Grantha, Kannada, Malayalam, Bengali, Oriya, Śāradā, Gujarati, and romanized/IAST), producing sibling files with the script name substituted into the filename. Requires an external `xsanscript` module not included in this repo. See the root README for more.
- `ekadashi/padma-puranam/splitChapters.sh` — splits the assembled Ekādaśī-māhātmya text from the Padma Purāṇa into the per-chapter files under `ekadashi/padma-puranam/chapters/`.

## Note

These files aren't listed in `../pujas.tex` directly; instead, the relevant puja file in `../pujas/` `\input`s its associated katha(s) itself, usually guarded by `\ifbool{katha}{...}{}` — e.g. `pujas/sriramanavami-puja.tex` pulls in `kathas/sriramanavami/sriramanavami-vrata-katha`. That toggle is off in the main `pujavidhanam.pdf` edition and on in both Kindle Scribe editions — see the root README.
