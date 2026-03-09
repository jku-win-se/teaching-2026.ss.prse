# Community Analyzer — Business Requirements

**Project:** Community Analyzer (DBLP)
**Course:** Praktikum Software Engineering — SS 2026
**Course Director:** Univ.-Prof. Dr. Manuel Wimmer
**Assistants:** Luca Berardinelli, Abbas Rahimi

---

## Overview

| Nr | Category | Requirement |
|----|----------|-------------|
| BR-01 | Core | Create a new community (name, description, …) |
| BR-02 | Core | Edit an existing community |
| BR-03 | Core | Delete a community |
| BR-04 | Core | Create, edit, and delete conferences and journals |
| BR-05 | Core | Each community can have multiple conferences and journals assigned |
| BR-06 | Core | Conferences and journals can have a rating (general / community-specific) |
| BR-07 | Core | Researchers publish in conferences and journals |
| BR-08 | Core | Base data can be imported from DBLP (XML, available at: https://dblp.uni-trier.de/xml) |
| BR-09 | Queries | Persons are displayed for a community (based on their publications) |
| BR-10 | Import/Export | Load and save community definitions to/from file |
| BR-11 | Analysis | Overlap of communities (who is active in two or more communities) |
| BR-12 | Analysis | Where do researchers publish who are no longer active in a selected community? |
| BR-13 | Filter | Journals and conferences can be filtered by ratings |
| BR-14 | Filter | Persons can be filtered by the ratings of their publications |
| BR-15 | Sorting | Conferences and journals can be sorted by rating |
| BR-16 | Sorting | Persons can be sorted by research output (count) |
| BR-17 | Sorting | Persons can be sorted by research output (weighted: publications + ratings) |
| BR-18 | Rating Import | Ratings for conferences can be automatically imported (http://gii-grin-scie-rating.scie.es/) |
| BR-19 | Rating Import | Ratings for journals can be automatically imported |
| BR-20 | Reporting | Graphical evaluation and presentation of analysis results in reports |

---

## Categories

| Category | BRs | Description |
|----------|-----|-------------|
| Core (CRUD) | BR-01 – BR-08 | Core functionality: Create, Read, Update, Delete entities |
| Queries | BR-09 | Queries based on publication data |
| Import/Export | BR-10 | Persistence of community definitions |
| Analysis | BR-11, BR-12 | Cross-community evaluations |
| Filter | BR-13, BR-14 | Restrict displayed results by criteria |
| Sorting | BR-15, BR-16, BR-17 | Order results by various metrics |
| Rating Import | BR-18, BR-19 | Automatic import of external ratings |
| Reporting | BR-20 | Graphical representation and reporting |

---

## Data Sources

| Source | URL | Used in |
|--------|-----|---------|
| DBLP XML | https://dblp.uni-trier.de/xml | BR-08 |
| GII-GRIN-SCIE Rating | http://gii-grin-scie-rating.scie.es/ | BR-18 |
| Journal Ratings | TBD (team's choice) | BR-19 |

---

## Notes

- Not all Business Requirements must be implemented. Teams choose a meaningful subset within the available budget (150h × 3 = 450 hours).
- BRs are refined by the teams into Software Requirements and User Stories.
