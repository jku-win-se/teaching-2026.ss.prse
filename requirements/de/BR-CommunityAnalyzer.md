# Community Analyzer — Geschäftsanforderungen (Business Requirements)

**Projekt:** Community Analyzer (DBLP)
**Kurs:** Praktikum Software Engineering — SS 2026
**LVA-Leiter:** Univ.-Prof. Dr. Manuel Wimmer
**Assistenten:** Luca Berardinelli, Abbas Rahimi

---

## Übersicht

| Nr | Kategorie | Anforderung |
|----|-----------|-------------|
| BR-01 | Basis | Anlegen einer neuen Community (Name, Beschreibung, …) |
| BR-02 | Basis | Ändern einer bereits angelegten Community |
| BR-03 | Basis | Löschen einer angelegten Community |
| BR-04 | Basis | Anlegen, ändern, und löschen von Konferenzen und Journalen |
| BR-05 | Basis | Jede Community kann mehrere Konferenzen und Journale zugewiesen bekommen |
| BR-06 | Basis | Konferenzen und Journale können ein Rating haben (allgemeines/Community-spezifisch) |
| BR-07 | Basis | Researcher publizieren in Konferenzen und Journalen |
| BR-08 | Basis | Basisdaten können von DBLP (XML, verfügbar unter: https://dblp.uni-trier.de/xml) importiert werden |
| BR-09 | Abfragen | Personen werden für eine Community angezeigt (auf Grund ihrer Publikationen) |
| BR-10 | Import/Export | Laden und speichern von/in Datei einer Community-Definition |
| BR-11 | Analyse | Überlappung von Communities (wer ist in zwei oder mehreren Communities aktiv) |
| BR-12 | Analyse | Wo publizieren Researcher, die nicht mehr in einer ausgewählten Community aktiv sind? |
| BR-13 | Filter | Journals und Konferenzen können nach Ratings gefiltert werden |
| BR-14 | Filter | Personen können nach Ratings ihrer Publikationen gefiltert werden |
| BR-15 | Sortieren | Konferenzen und Journals können nach Rating sortiert werden |
| BR-16 | Sortieren | Personen können nach Forschungsoutput (Anzahl) sortiert werden |
| BR-17 | Sortieren | Personen können nach Forschungsoutput (Gewichtet: Publikationen + Ratings) sortiert werden |
| BR-18 | Rating-Import | Ratings für Konferenzen können automatisch importiert werden (http://gii-grin-scie-rating.scie.es/) |
| BR-19 | Rating-Import | Ratings für Journale können automatisch importiert werden |
| BR-20 | Auswertung | Grafische Auswertung und Darstellung von Analyseergebnissen in Berichten |

---

## Kategorien

| Kategorie | BRs | Beschreibung |
|-----------|-----|--------------|
| Basis (CRUD) | BR-01 – BR-08 | Kernfunktionalität: Erstellen, Lesen, Ändern, Löschen von Entitäten |
| Abfragen | BR-09 | Abfragen auf Basis von Publikationsdaten |
| Import/Export | BR-10 | Persistenz von Community-Definitionen |
| Analyse | BR-11, BR-12 | Community-übergreifende Auswertungen |
| Filter | BR-13, BR-14 | Einschränkung der Anzeige nach Kriterien |
| Sortieren | BR-15, BR-16, BR-17 | Ordnung der Ergebnisse |
| Rating-Import | BR-18, BR-19 | Automatischer Import von externen Ratings |
| Auswertung | BR-20 | Grafische Darstellung und Berichtswesen |

---

## Datenquellen

| Quelle | URL | Verwendet in |
|--------|-----|--------------|
| DBLP XML | https://dblp.uni-trier.de/xml | BR-08 |
| GII-GRIN-SCIE Rating | http://gii-grin-scie-rating.scie.es/ | BR-18 |
| Journal-Ratings | TBD (Entscheidung des Teams) | BR-19 |

---

## Hinweise

- Nicht alle Geschäftsanforderungen müssen umgesetzt werden. Teams wählen ein sinnvolles Subset für das verfügbare Budget (150h × 3 = 450 Stunden).
- Die BRs werden von den Teams in Software Requirements und User Stories verfeinert.
