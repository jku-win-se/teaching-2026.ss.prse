# Community Analyzer — Vollständige User Stories (Interne Referenz)

**Verwendung:** Internes Dokument für Assistenten (Luca Berardinelli, Abbas Rahimi)
**Nicht an Studierende verteilen** — die Studierenden müssen ihre eigenen SR und US erstellen.

---

## BR-01: Anlegen einer neuen Community

**US-001: Neue Community anlegen**
- Verknüpftes BR: BR-01
- Meilenstein: Release 1
- Story: Als Forscher möchte ich eine neue Community mit Name und Beschreibung anlegen, damit ich Konferenzen und Journale rund um ein Forschungsthema organisieren kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann einen Community-Namen (Pflichtfeld, eindeutig, 3–100 Zeichen) und eine optionale Beschreibung eingeben
  - [ ] Klick auf "Erstellen" speichert die Community (Datei oder Datenbank)
  - [ ] Die neue Community erscheint in der Community-Liste
  - [ ] Doppelte Namen werden mit einer aussagekräftigen Fehlermeldung abgelehnt
  - [ ] Leere oder ungültige Namen werden mit einer aussagekräftigen Fehlermeldung abgelehnt

---

## BR-02: Ändern einer bereits angelegten Community

**US-002: Bestehende Community bearbeiten**
- Verknüpftes BR: BR-02
- Meilenstein: Release 1
- Story: Als Forscher möchte ich den Namen und die Beschreibung einer Community bearbeiten, damit die Informationen aktuell bleiben.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine Community aus der Liste auswählen und "Bearbeiten" klicken
  - [ ] Ein Formular wird mit dem aktuellen Namen und der Beschreibung vorausgefüllt
  - [ ] Änderungen werden nach Klick auf "Speichern" persistiert
  - [ ] Validierungsregeln (eindeutiger Name, Länge) gelten auch beim Bearbeiten
  - [ ] Abbrechen verwirft die Änderungen

---

## BR-03: Löschen einer angelegten Community

**US-003: Community löschen**
- Verknüpftes BR: BR-03
- Meilenstein: Release 1
- Story: Als Forscher möchte ich eine nicht mehr benötigte Community löschen, damit mein Arbeitsbereich übersichtlich bleibt.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine Community auswählen und "Löschen" klicken
  - [ ] Ein Bestätigungsdialog fragt "Sind Sie sicher?"
  - [ ] Bei Bestätigung werden die Community und ihre Zuordnungen (Konferenzen/Journale) entfernt
  - [ ] Bei Abbruch passiert nichts
  - [ ] Gelöschte Community erscheint nicht mehr in der Liste

---

## BR-04: Anlegen, ändern, und löschen von Konferenzen und Journalen

**US-004: Konferenz anlegen**
- Verknüpftes BR: BR-04
- Meilenstein: Release 1
- Story: Als Forscher möchte ich einen neuen Konferenzeintrag mit Name, Abkürzung und Typ anlegen, damit ich Publikationen in diesem Venue verfolgen kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann Konferenzname (Pflichtfeld), Abkürzung und Typ = "Konferenz" eingeben
  - [ ] Konferenz wird gespeichert und ist in der Venue-Liste sichtbar
  - [ ] Doppelte Namen/Abkürzungen innerhalb des gleichen Typs werden abgelehnt

**US-005: Journal anlegen**
- Verknüpftes BR: BR-04
- Meilenstein: Release 1
- Story: Als Forscher möchte ich einen neuen Journaleintrag anlegen, damit ich Journal-Publikationen getrennt von Konferenzen verfolgen kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann Journalname (Pflichtfeld), Abkürzung, ISSN (optional) und Typ = "Journal" eingeben
  - [ ] Journal wird gespeichert und ist in der Venue-Liste sichtbar

**US-006: Konferenz oder Journal bearbeiten**
- Verknüpftes BR: BR-04
- Meilenstein: Release 1
- Story: Als Forscher möchte ich eine bestehende Konferenz oder ein Journal bearbeiten, damit ich Venue-Informationen korrigieren oder aktualisieren kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann einen Venue auswählen und "Bearbeiten" klicken
  - [ ] Formular wird mit aktuellen Daten vorausgefüllt
  - [ ] Änderungen werden validiert und gespeichert

**US-007: Konferenz oder Journal löschen**
- Verknüpftes BR: BR-04
- Meilenstein: Release 1
- Story: Als Forscher möchte ich eine nicht mehr benötigte Konferenz oder ein Journal löschen.
- Akzeptanzkriterien:
  - [ ] Benutzer kann einen Venue auswählen und "Löschen" klicken
  - [ ] Bestätigungsdialog wird angezeigt
  - [ ] Bei Bestätigung wird der Venue zusammen mit seinen Community-Zuordnungen entfernt
  - [ ] Publikationen, die mit diesem Venue verknüpft sind, werden markiert oder ordnungsgemäß behandelt

---

## BR-05: Jede Community kann mehrere Konferenzen und Journale zugewiesen bekommen

**US-008: Venues einer Community zuordnen**
- Verknüpftes BR: BR-05
- Meilenstein: Release 1
- Story: Als Forscher möchte ich einer Community mehrere Konferenzen und Journale zuordnen, damit die Community die relevanten Publikationsvenues widerspiegelt.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine Community öffnen und "Venues zuordnen" klicken
  - [ ] Eine Liste verfügbarer Konferenzen und Journale wird angezeigt (Mehrfachauswahl)
  - [ ] Ausgewählte Venues werden mit der Community verknüpft
  - [ ] Bereits zugeordnete Venues sind vorausgewählt

**US-009: Venue-Zuordnung aus einer Community entfernen**
- Verknüpftes BR: BR-05
- Meilenstein: Release 1
- Story: Als Forscher möchte ich einen Venue aus einer Community entfernen, wenn er nicht mehr relevant ist.
- Akzeptanzkriterien:
  - [ ] Benutzer kann einen Venue in der Zuordnungsansicht abwählen
  - [ ] Die Venue-Community-Verknüpfung wird entfernt
  - [ ] Der Venue selbst wird nicht gelöscht, nur die Zuordnung

---

## BR-06: Konferenzen und Journale können ein Rating haben

**US-010: Allgemeines Rating einem Venue zuordnen**
- Verknüpftes BR: BR-06
- Meilenstein: Release 2
- Story: Als Forscher möchte ich einer Konferenz oder einem Journal ein allgemeines Rating (z.B. A*, A, B, C) zuordnen, damit ich die Venue-Qualität bewerten kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann einen Venue auswählen und ein allgemeines Rating aus einer vordefinierten Skala setzen
  - [ ] Rating wird gespeichert und in der Venue-Liste angezeigt
  - [ ] Rating kann aktualisiert oder entfernt werden

**US-011: Community-spezifisches Rating einem Venue zuordnen**
- Verknüpftes BR: BR-06
- Meilenstein: Release 2
- Story: Als Forscher möchte ich einem Venue ein Community-spezifisches Rating zuordnen, damit verschiedene Communities denselben Venue unterschiedlich bewerten können.
- Akzeptanzkriterien:
  - [ ] Benutzer kann ein Rating für einen Venue im Kontext einer bestimmten Community setzen
  - [ ] Community-spezifisches Rating wird getrennt vom allgemeinen Rating angezeigt
  - [ ] Beide Ratings koexistieren ohne Konflikt

---

## BR-07: Researcher publizieren in Konferenzen und Journalen

**US-012: Forscher-Publikationen anzeigen**
- Verknüpftes BR: BR-07
- Meilenstein: Release 2
- Story: Als Forscher möchte ich sehen, welche Forscher in welchen Konferenzen und Journalen publiziert haben, damit ich Publikationsmuster verstehen kann.
- Akzeptanzkriterien:
  - [ ] Auswahl eines Venues zeigt eine Liste der Forscher, die dort publiziert haben
  - [ ] Auswahl eines Forschers zeigt eine Liste seiner Publikationen mit Venue und Jahr
  - [ ] Publikationsanzahl pro Venue wird angezeigt

**US-013: Publikationen mit Forschern und Venues verknüpfen**
- Verknüpftes BR: BR-07
- Meilenstein: Release 2
- Story: Als System werden Publikationen, die aus DBLP importiert werden, automatisch mit ihren jeweiligen Forschern und Venues verknüpft.
- Akzeptanzkriterien:
  - [ ] Nach dem DBLP-Import ist jede Publikation mit ihren Autoren und ihrem Venue verknüpft
  - [ ] Forscher mit gleichem Namen werden behandelt (Disambiguierung oder Zusammenführung)
  - [ ] Venue-Zuordnung verwendet den DBLP-Schlüssel zur Identifikation von Konferenzen/Journalen

---

## BR-08: Basisdaten können von DBLP importiert werden

**US-014: DBLP XML-Daten importieren**
- Verknüpftes BR: BR-08
- Meilenstein: Release 2
- Story: Als Forscher möchte ich Publikationsdaten aus einer DBLP XML-Datei importieren, damit ich das System mit realen Forschungsdaten befüllen kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine DBLP XML-Datei über einen Datei-Dialog auswählen
  - [ ] System verwendet Streaming-Parsing (SAX/StAX) für große Dateien (bis 4 GB)
  - [ ] Extrahierte Daten: Autorenname(n), Publikationstitel, Jahr, Venue-Schlüssel
  - [ ] Import läuft in einem Hintergrund-Thread — UI bleibt reaktionsfähig
  - [ ] Ein Fortschrittsindikator zeigt die Anzahl der verarbeiteten Datensätze
  - [ ] Erfolgs-/Fehlermeldung wird bei Abschluss angezeigt

**US-015: DBLP-Import nach Venue-Subset filtern**
- Verknüpftes BR: BR-08
- Meilenstein: Release 3
- Story: Als Forscher möchte ich nur Daten für bestimmte Konferenzen oder Journale aus DBLP importieren, damit ich mich auf relevante Venues konzentrieren kann, ohne den gesamten Datensatz zu importieren.
- Akzeptanzkriterien:
  - [ ] Benutzer kann vor dem Import eine Liste von Venue-Schlüsseln oder -Namen angeben
  - [ ] Nur Publikationen, die den angegebenen Venues entsprechen, werden importiert
  - [ ] Nicht übereinstimmende Einträge werden stillschweigend übersprungen

---

## BR-09: Personen werden für eine Community angezeigt

**US-016: Forscher einer Community auflisten**
- Verknüpftes BR: BR-09
- Meilenstein: Release 2
- Story: Als Forscher möchte ich alle Personen sehen, die in Venues einer Community publiziert haben, damit ich verstehe, wer in diesem Forschungsbereich aktiv ist.
- Akzeptanzkriterien:
  - [ ] Auswahl einer Community zeigt eine Liste von Forschern
  - [ ] Forscher werden anhand mindestens einer Publikation in einem zugeordneten Venue bestimmt
  - [ ] Jeder Eintrag zeigt Forschername und Publikationsanzahl in dieser Community
  - [ ] Liste ist nach Name und Publikationsanzahl sortierbar

---

## BR-10: Laden und speichern von/in Datei einer Community-Definition

**US-017: Community-Definition in Datei exportieren**
- Verknüpftes BR: BR-10
- Meilenstein: Release 2
- Story: Als Forscher möchte ich eine Community-Definition (Name, Beschreibung, zugeordnete Venues, Ratings) in eine Datei exportieren, damit ich sie sichern oder teilen kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine Community auswählen und "Exportieren" klicken
  - [ ] Ein Datei-Dialog ermöglicht die Auswahl des Ausgabepfads und -formats (JSON oder XML)
  - [ ] Die exportierte Datei enthält: Community-Metadaten, Venue-Zuordnungen, Ratings
  - [ ] Datei ist für Menschen lesbar

**US-018: Community-Definition aus Datei importieren**
- Verknüpftes BR: BR-10
- Meilenstein: Release 2
- Story: Als Forscher möchte ich eine Community-Definition aus einer Datei importieren, damit ich Community-Konfigurationen wiederherstellen oder teilen kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine Datei über einen Datei-Dialog auswählen
  - [ ] System validiert das Dateiformat vor dem Import
  - [ ] Importierte Community erscheint in der Liste mit allen Venue-Zuordnungen und Ratings
  - [ ] Konflikte (z.B. doppelter Community-Name) werden mit einer Benutzerabfrage behandelt

---

## BR-11: Überlappung von Communities

**US-019: Community-Überlappung analysieren**
- Verknüpftes BR: BR-11
- Meilenstein: Release 3
- Story: Als Forscher möchte ich sehen, welche Forscher in zwei oder mehr Communities aktiv sind, damit ich interdisziplinäre Forscher identifizieren kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann zwei oder mehr Communities zum Vergleich auswählen
  - [ ] System zeigt eine Liste der Forscher, die in ALLEN ausgewählten Communities aktiv sind
  - [ ] Jedes Ergebnis zeigt den Forschernamen und die Communities, in denen er aktiv ist
  - [ ] Ergebnisanzahl (Anzahl überlappender Forscher) wird angezeigt
  - [ ] Ergebnisse können nach Name oder Publikationsanzahl sortiert werden

---

## BR-12: Wo publizieren Researcher, die nicht mehr in einer Community aktiv sind?

**US-020: Forscher verfolgen, die eine Community verlassen haben**
- Verknüpftes BR: BR-12
- Meilenstein: Release 3
- Story: Als Forscher möchte ich wissen, wo Forscher, die zuvor in einer Community aktiv waren, jetzt publizieren, damit ich Migrationsmuster verfolgen kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine Community auswählen und ein "Aktivitätsfenster" definieren (z.B. keine Publikationen in den letzten N Jahren)
  - [ ] System identifiziert Forscher, die aktiv waren, aber nicht mehr in dieser Community publizieren
  - [ ] Für jeden inaktiven Forscher zeigt das System seine aktuellen Publikationsvenues
  - [ ] Ergebnisse sind sortierbar nach Forschername, letztem aktiven Jahr und aktueller Venue-Anzahl

---

## BR-13: Journals und Konferenzen können nach Ratings gefiltert werden

**US-021: Venues nach Rating filtern**
- Verknüpftes BR: BR-13
- Meilenstein: Release 2
- Story: Als Forscher möchte ich die Liste der Konferenzen und Journale nach Rating filtern, damit ich mich auf hochwertige Venues konzentrieren kann.
- Akzeptanzkriterien:
  - [ ] Ein Rating-Filter (Dropdown/Checkbox) ist in der Venue-Listenansicht verfügbar
  - [ ] Auswahl eines Ratings (z.B. "nur A*", "A und höher") filtert die angezeigten Venues
  - [ ] Filter gilt für allgemeine und Community-spezifische Ratings (Benutzer wählt)
  - [ ] Zurücksetzen des Filters zeigt alle Venues wieder an

---

## BR-14: Personen können nach Ratings ihrer Publikationen gefiltert werden

**US-022: Forscher nach Publikations-Venue-Rating filtern**
- Verknüpftes BR: BR-14
- Meilenstein: Release 3
- Story: Als Forscher möchte ich Forscher anhand der Ratings der Venues filtern, in denen sie publizieren, damit ich Forscher identifizieren kann, die regelmäßig in Top-Venues publizieren.
- Akzeptanzkriterien:
  - [ ] Ein Rating-Filter ist in der Forscher-Listenansicht verfügbar
  - [ ] Auswahl eines Mindest-Ratings filtert auf Forscher mit mindestens einer Publikation in einem Venue mit diesem Rating oder höher
  - [ ] Filter kann mit Community-Auswahl kombiniert werden
  - [ ] Ergebnisanzahl wird dynamisch aktualisiert

---

## BR-15: Konferenzen und Journals können nach Rating sortiert werden

**US-023: Venues nach Rating sortieren**
- Verknüpftes BR: BR-15
- Meilenstein: Release 2
- Story: Als Forscher möchte ich Konferenzen und Journale nach ihrem Rating sortieren, damit ich die am höchsten bewerteten Venues schnell sehen kann.
- Akzeptanzkriterien:
  - [ ] Klick auf die Spaltenüberschrift "Rating" sortiert Venues aufsteigend/absteigend
  - [ ] Sortierung funktioniert für allgemeine und Community-spezifische Ratings
  - [ ] Venues ohne Rating werden am Ende platziert

---

## BR-16: Personen können nach Forschungsoutput (Anzahl) sortiert werden

**US-024: Forscher nach Publikationsanzahl sortieren**
- Verknüpftes BR: BR-16
- Meilenstein: Release 2
- Story: Als Forscher möchte ich Forscher nach der Anzahl der Publikationen sortieren, damit ich die produktivsten Beitragenden identifizieren kann.
- Akzeptanzkriterien:
  - [ ] Klick auf die Spaltenüberschrift "Publikationen" sortiert Forscher aufsteigend/absteigend
  - [ ] Anzahl spiegelt Publikationen in den Venues der ausgewählten Community wider (wenn eine Community ausgewählt ist)
  - [ ] Anzahl spiegelt alle Publikationen wider, wenn kein Community-Filter aktiv ist

---

## BR-17: Personen können nach Forschungsoutput (Gewichtet) sortiert werden

**US-025: Forscher nach gewichtetem Forschungsoutput sortieren**
- Verknüpftes BR: BR-17
- Meilenstein: Release 3
- Story: Als Forscher möchte ich Forscher nach einem gewichteten Score sortieren, der sowohl Publikationsanzahl als auch Venue-Ratings berücksichtigt, damit ich den Forschungsimpact genauer bewerten kann.
- Akzeptanzkriterien:
  - [ ] Eine Spalte "Gewichteter Score" ist in der Forscher-Liste verfügbar
  - [ ] Score-Formel: Summe von (Rating-Gewicht × Publikationen in diesem Venue) pro Forscher
  - [ ] Rating-Gewichte sind konfigurierbar (z.B. A*=4, A=3, B=2, C=1, ohne Rating=0)
  - [ ] Klick auf die Spaltenüberschrift sortiert nach gewichtetem Score aufsteigend/absteigend
  - [ ] Tooltip oder Hilfetext erklärt die Bewertungsformel

---

## BR-18: Ratings für Konferenzen können automatisch importiert werden

**US-026: Konferenz-Ratings von GII-GRIN-SCIE importieren**
- Verknüpftes BR: BR-18
- Meilenstein: Release 3
- Story: Als Forscher möchte ich Konferenz-Ratings automatisch aus der GII-GRIN-SCIE-Datenbank importieren, damit ich sie nicht manuell eingeben muss.
- Akzeptanzkriterien:
  - [ ] Benutzer kann "Konferenz-Ratings importieren" aus dem Menü auslösen
  - [ ] System ruft Daten von http://gii-grin-scie-rating.scie.es/ ab (Web-Scraping oder API)
  - [ ] Importierte Ratings werden bestehenden Konferenzen nach Name oder Abkürzung zugeordnet
  - [ ] Zugeordnete Ratings werden als allgemeine Ratings angewendet
  - [ ] Nicht zugeordnete Konferenzen werden in einem Bericht zur manuellen Überprüfung aufgelistet
  - [ ] Import-Fortschritt und Ergebniszusammenfassung werden angezeigt

---

## BR-19: Ratings für Journale können automatisch importiert werden

**US-027: Journal-Ratings aus externer Quelle importieren**
- Verknüpftes BR: BR-19
- Meilenstein: Release 3
- Story: Als Forscher möchte ich Journal-Ratings automatisch aus einer externen Quelle importieren, damit ich sie nicht manuell eingeben muss.
- Akzeptanzkriterien:
  - [ ] Benutzer kann "Journal-Ratings importieren" aus dem Menü auslösen
  - [ ] System unterstützt mindestens eine Journal-Rating-Quelle (z.B. SJR, JCR oder CSV-Upload)
  - [ ] Importierte Ratings werden bestehenden Journalen nach Name oder ISSN zugeordnet
  - [ ] Zugeordnete Ratings werden als allgemeine Ratings angewendet
  - [ ] Nicht zugeordnete Journale werden zur manuellen Überprüfung aufgelistet
  - [ ] Import-Fortschritt und Ergebniszusammenfassung werden angezeigt

---

## BR-20: Grafische Auswertung und Darstellung von Analyseergebnissen

**US-028: Community-Statistiken als Diagramme anzeigen**
- Verknüpftes BR: BR-20
- Meilenstein: Release 3
- Story: Als Forscher möchte ich grafische Berichte über eine Community sehen (z.B. Publikationstrends, Venue-Verteilung), damit ich Forschungsmuster schnell verstehen kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine "Berichte"-Ansicht für eine ausgewählte Community öffnen
  - [ ] Mindestens 3 Diagrammtypen sind verfügbar (z.B. Balkendiagramm, Kreisdiagramm, Liniendiagramm)
  - [ ] Balkendiagramm: Publikationen pro Jahr
  - [ ] Kreisdiagramm: Verteilung der Publikationen auf Venues
  - [ ] Liniendiagramm: Publikationstrend über die Zeit
  - [ ] Diagramme werden aktualisiert, wenn sich die zugrunde liegenden Daten ändern

**US-029: Berichte exportieren**
- Verknüpftes BR: BR-20
- Meilenstein: Release 3
- Story: Als Forscher möchte ich grafische Berichte als PDF oder Bilder exportieren, damit ich sie in Präsentationen oder Dokumente einbinden kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann "Exportieren" in jeder Diagrammansicht klicken
  - [ ] Exportformate: PNG und/oder PDF
  - [ ] Exportierte Datei enthält Diagrammtitel, Datum und Community-Name
  - [ ] Datei-Dialog ermöglicht die Auswahl des Ausgabeorts

---

## Zusammenfassung: User Stories pro Release

| Release | User Stories | Abgedeckte BRs |
|---------|-------------|----------------|
| Release 1 | US-001 – US-009 | BR-01, BR-02, BR-03, BR-04, BR-05 |
| Release 2 | US-010 – US-018, US-021, US-023, US-024 | BR-06, BR-07, BR-08, BR-09, BR-10, BR-13, BR-15, BR-16 |
| Release 3 | US-019, US-020, US-022, US-025 – US-029 | BR-11, BR-12, BR-14, BR-17, BR-18, BR-19, BR-20 |

| Summen | |
|--------|---|
| Geschäftsanforderungen | 20 (BR-01 – BR-20) |
| User Stories | 29 |
