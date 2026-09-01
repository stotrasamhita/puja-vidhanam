# pujas/

One `.tex` file per puja or vrata — the core content of *Puja Vidhanam*. Each file is a self-contained chapter that can be compiled on its own (see the root README's build section) or pulled into the full book via the `\input` list in [`../pujas.tex`](../pujas.tex), which is also where the grouping below comes from.

## Daily and periodic pujas

Performed daily, on recurring tithis, or on a fixed periodic schedule rather than once a year:

- `laghu-panchayatana-puja.tex` — the short/abbreviated pañcāyatana pūjā (worship of the five deities together).
- `surya-arghyam.tex` — daily arghya to Sūrya.
- `ekadashi-purusha-sukta-vidhana-puja.tex` — Ekādaśī pūjā to Mahāviṣṇu using the Puruṣa Sūkta.
- `sankataharachaturthi-vinayaka-puja.tex` — Vināyaka pūjā for Saṅkaṣṭahara Caturthī (the monthly Gaṇeśa caturthī).
- `panchanga-puja.tex` — worship of the pañcāṅga (almanac) itself, typically done at the start of the year/day's rites.

## Annual vrata pujas

Tied to a specific yearly festival or observance:

- `sriramanavami-puja.tex` — Śrī Rāmanavamī.
- `shankara-jayanti-puja.tex` — Śaṅkara Jayantī (birth anniversary of Ādi Śaṅkara).
- `nrisimha-jayanti-puja.tex` — Nṛsiṃha Jayantī.
- `chitragupta-puja.tex` — Citragupta pūjā.
- `vyasa-puja.tex` — Vyāsa pūjā (Guru Pūrṇimā).
- `varamahalakshmi-puja.tex` — Varamahālakṣmī vratam.
- `yajur-upakarma.tex` — Yajur Upākarma (only included in editions built with the `veda` toggle on — see the root README).
- `janmashtami-puja.tex` — Kṛṣṇa Janmāṣṭamī.
- `siddhivinayaka-puja.tex` — Siddhivināyaka pūjā.
- `uma-maheshvara-puja.tex` — Umā-Maheśvara pūjā.
- `sarasvati-puja.tex` — Sarasvatī pūjā.
- `dhanvantari-puja.tex` — Dhanvantari pūjā.
- `lakshmi-kubera-puja.tex` — Lakṣmī-Kubera pūjā.
- `skanda-shashthi-puja.tex` — Skanda Ṣaṣṭhī.
- `brindavana-puja.tex` — Bṛndāvana (tulasī) pūjā.
- `surya-puja.tex` — Sūrya pūjā.
- `go-puja.tex` — Go (cow) pūjā.
- `shivaratri-puja.tex` — Mahāśivarātri: the main file assembles the night-long observance from the four separate yāma files below via `\input`.
  - `shivaratri-yama-1-puja.tex`, `shivaratri-yama-2-puja.tex`, `shivaratri-yama-3-puja.tex`, `shivaratri-yama-4-puja.tex` — the pūjā for each of the four yāma-s (watches) of the night. `shivaratri-yama-2-puja.tex` in turn pulls in `MahaNyasah.tex`.
- `savitri-vratam.tex` — Sāvitrī vratam.

## Occasional rites (naimittika)

Not tied to one annual date — performed on an occurring astronomical/calendrical event, or as a periodic remembrance:

- `sankramana-snanam.tex` — the bath/rite observed at a saṅkrāmaṇa (solar transit into a new rāśi).
- `shravana-mahatmyam.tex` — glory/observance associated with the month of Śrāvaṇa.
- `kartika-somavara-arghyam.tex` — arghya offered on Mondays in Kārtika.
- `kartika-mahatmyam.tex` — glory/observance associated with the month of Kārtika.
- `ganga-puja.tex` — Gaṅgā pūjā.
- `kaveri-puja.tex` — Kāverī pūjā.
- `surya-namaskara.tex` — Sūrya Namaskāra.
- `yama-tarpanam.tex` — tarpaṇa to Yama.
- `bhishma-tarpanam.tex` — tarpaṇa to Bhīṣma.

## Include-only / reference files

- `MahaNyasah.tex` — the Mahānyāsa recitation, `\input` from `shivaratri-yama-2-puja.tex` rather than compiled or listed on its own.
- `rudra-prashnah.tex` — the Rudra Praśna text; referenced (currently commented out) from `MahaNyasah.tex`.

## `old/`

Superseded material, kept for reference rather than compiled into the current book:

- `tulasi-puja.tex` and `tulasi-puja-old.tex` — two earlier drafts of a Tulasī pūjā (the current one is `brindavana-puja.tex` above).
- `ekadashi.tex` — an earlier standalone Ekādaśī vrata writeup, superseded by `ekadashi-purusha-sukta-vidhana-puja.tex`.

None of the files in `old/` are `\input` by `../pujas.tex`.
