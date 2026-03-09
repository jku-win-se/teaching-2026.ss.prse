# Community Analyzer — Von Geschäftsanforderungen zu User Stories

## Ein Leitfaden für Studierende

**Kurs:** Praktikum Software Engineering — SS 2026

Dieses Dokument erklärt, wie Geschäftsanforderungen (Business Requirements, BR) in Software Requirements (SR) und User Stories (US) verfeinert werden. Es enthält konkrete Beispiele aus dem Community Analyzer Projekt.

---

## 1. Die Verfeinerungskette

```
Geschäftsanforderung (BR)        — Was der Kunde will (abstrakt)
  └→ Software Requirement (SR)     — Wie wir es technisch spezifizieren (messbar, prüfbar)
      └→ User Story (US)             — Wie wir es in einem Sprint implementieren (testbar)
          └→ Akzeptanzkriterien        — Wie wir prüfen, ob es fertig ist
```

**Wichtige Regeln:**
- Ein BR kann mehrere SRs erzeugen
- Ein SR kann eine oder mehrere USs erzeugen
- Eine US kann mit mehreren SRs verknüpft sein (nur wenn es wirklich sinnvoll ist)
- Nicht alle BRs müssen umgesetzt werden — wählen Sie ein sinnvolles Subset für Ihr Budget (450 Stunden)

---

## 2. Namenskonventionen

| Ebene | Format | Beispiel |
|-------|--------|----------|
| Geschäftsanforderung | BR-NN | BR-08 |
| Software Requirement | SR-NN.X | SR-08.1, SR-08.2 |
| User Story | US-NNN | US-001, US-002 |

---

## 3. Software Requirement Vorlage

```markdown
### SR-NN.X: [Titel]

**Verknüpftes BR:** BR-NN
**Priorität:** Muss / Soll / Kann
**Beschreibung:** Das System soll [messbares Verhalten].
**Einschränkungen:** [Technische Einschränkungen, Formate, Grenzen]
**Verifikation:** [Wie wird diese Anforderung überprüft]
```

---

## 4. User Story Vorlage

```markdown
### US-NNN: [Titel]

**Verknüpftes SR:** SR-NN.X, SR-NN.Y
**Verantwortliche(r):** [Teammitglied]
**Meilenstein:** Release N
**Story:** Als [Rolle] möchte ich [Ziel], damit [Nutzen].

**Akzeptanzkriterien:**
- [ ] [Kriterium 1 — testbar]
- [ ] [Kriterium 2 — testbar]
- [ ] [Kriterium 3 — testbar]
```

---

## 5. Beispiel: BR-01 (Community anlegen)

### Geschäftsanforderung

> **BR-01:** Anlegen einer neuen Community (Name, Beschreibung, …)

### Software Requirements

**SR-01.1: Community mit Pflichtfeldern anlegen**
- Verknüpftes BR: BR-01
- Priorität: Muss
- Beschreibung: Das System soll es dem Benutzer ermöglichen, eine neue Community durch Angabe eines Namens (Pflichtfeld, eindeutig) und einer Beschreibung (optional) anzulegen.
- Einschränkungen: Community-Name muss zwischen 3 und 100 Zeichen lang sein. Doppelte Namen sind nicht erlaubt.
- Verifikation: Versuch, eine Community mit gültigen Daten anzulegen → Community wird gespeichert und ist in der Liste sichtbar.

**SR-01.2: Eingabevalidierung beim Anlegen einer Community**
- Verknüpftes BR: BR-01
- Priorität: Muss
- Beschreibung: Das System soll alle Eingabefelder vor dem Anlegen einer Community validieren und aussagekräftige Fehlermeldungen bei ungültiger Eingabe anzeigen.
- Einschränkungen: Leerer Name, doppelter Name, Name über 100 Zeichen müssen abgelehnt werden.
- Verifikation: Versuch, eine Community mit leerem Namen anzulegen → Fehlermeldung wird angezeigt, Community wird nicht erstellt.

### User Stories

**US-001: Neue Community anlegen**
- Verknüpftes SR: SR-01.1
- Meilenstein: Release 1
- Story: Als Forscher möchte ich eine neue Community mit Name und Beschreibung anlegen, damit ich Konferenzen und Journale rund um ein Forschungsthema organisieren kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann einen Community-Namen und eine optionale Beschreibung in einem Formular eingeben
  - [ ] Klick auf "Erstellen" speichert die Community
  - [ ] Die neue Community erscheint in der Community-Liste
  - [ ] Community-Name muss eindeutig sein

**US-002: Eingabevalidierung für Communities**
- Verknüpftes SR: SR-01.2
- Meilenstein: Release 1
- Story: Als Benutzer möchte ich klare Fehlermeldungen sehen, wenn ich ungültige Daten eingebe, damit ich meine Eingaben korrigieren kann.
- Akzeptanzkriterien:
  - [ ] Leerer Name zeigt Fehler "Community-Name ist erforderlich"
  - [ ] Doppelter Name zeigt Fehler "Eine Community mit diesem Namen existiert bereits"
  - [ ] Name über 100 Zeichen zeigt Fehler "Name darf nicht länger als 100 Zeichen sein"

---

## 6. Beispiel: BR-08 (DBLP-Import)

### Geschäftsanforderung

> **BR-08:** Basisdaten können von DBLP (XML, verfügbar unter: https://dblp.uni-trier.de/xml) importiert werden

### Software Requirements

**SR-08.1: DBLP XML-Dateien einlesen**
- Verknüpftes BR: BR-08
- Priorität: Muss
- Beschreibung: Das System soll DBLP XML-Dateien mit einem Streaming-Parser (SAX oder StAX) einlesen, um große Dateien effizient zu verarbeiten.
- Einschränkungen: Muss Dateien bis mindestens 4 GB verarbeiten können. Darf die gesamte Datei nicht in den Speicher laden.
- Verifikation: Import einer großen DBLP XML-Datei → Import wird ohne OutOfMemoryError abgeschlossen.

**SR-08.2: Publikationsmetadaten extrahieren**
- Verknüpftes BR: BR-08
- Priorität: Muss
- Beschreibung: Das System soll folgende Felder aus DBLP-Einträgen extrahieren: Autorenname(n), Publikationstitel, Jahr, Venue (Konferenz- oder Journal-Schlüssel).
- Einschränkungen: Publikationen ohne Jahr oder ohne Autoren können mit einer Warnung übersprungen werden.
- Verifikation: Import einer Beispiel-DBLP-Datei → extrahierte Daten stimmen mit erwarteten Werten für bekannte Publikationen überein.

**SR-08.3: Import-Fortschritt anzeigen**
- Verknüpftes BR: BR-08
- Priorität: Soll
- Beschreibung: Das System soll während des DBLP-Imports einen Fortschrittsindikator anzeigen, der mindestens die Anzahl der verarbeiteten Datensätze zeigt.
- Einschränkungen: Die Benutzeroberfläche muss während des Imports reaktionsfähig bleiben (Hintergrund-Thread).
- Verifikation: Import starten → Fortschrittsanzeige wird aktualisiert, UI friert nicht ein.

### User Stories

**US-010: DBLP XML-Daten importieren**
- Verknüpfte SRs: SR-08.1, SR-08.2
- Meilenstein: Release 2
- Story: Als Forscher möchte ich Publikationsdaten aus einer DBLP XML-Datei importieren, damit ich meine Community mit realen Forschungsdaten befüllen kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann eine DBLP XML-Datei über einen Datei-Dialog auswählen
  - [ ] Import extrahiert Autor, Titel, Jahr, Venue für jede Publikation
  - [ ] Import wird für Dateien bis 4 GB fehlerfrei abgeschlossen
  - [ ] Importierte Daten sind nach dem Import in der Anwendung sichtbar

**US-011: Import-Fortschritt anzeigen**
- Verknüpftes SR: SR-08.3
- Meilenstein: Release 2
- Story: Als Benutzer möchte ich den Import-Fortschritt sehen, damit ich weiß, dass der Import funktioniert und abschätzen kann, wie lange er dauert.
- Akzeptanzkriterien:
  - [ ] Ein Fortschrittsbalken oder Zähler wird während des Imports angezeigt
  - [ ] Die Benutzeroberfläche bleibt während des Imports reaktionsfähig (nicht eingefroren)
  - [ ] Eine Erfolgsmeldung erscheint nach Abschluss des Imports

---

## 7. Beispiel: BR-11 (Community-Überlappung)

### Geschäftsanforderung

> **BR-11:** Überlappung von Communities (wer ist in zwei oder mehreren Communities aktiv)

### Software Requirements

**SR-11.1: Community-Überlappung berechnen**
- Verknüpftes BR: BR-11
- Priorität: Muss
- Beschreibung: Das System soll die Menge der Forscher berechnen, die in zwei oder mehr ausgewählten Communities aktiv sind, basierend auf ihren Publikationen in Konferenzen/Journalen, die diesen Communities zugeordnet sind.
- Einschränkungen: "Aktiv" bedeutet mindestens eine Publikation in einem der Community zugeordneten Venue.
- Verifikation: Zwei Communities mit bekannten überlappenden Forschern auswählen → System zeigt die korrekte Überlappungsmenge an.

### User Stories

**US-019: Community-Überlappung analysieren**
- Verknüpftes SR: SR-11.1
- Meilenstein: Release 3
- Story: Als Forscher möchte ich sehen, welche Forscher in mehreren Communities aktiv sind, damit ich interdisziplinäre Forscher identifizieren kann.
- Akzeptanzkriterien:
  - [ ] Benutzer kann zwei oder mehr Communities zum Vergleich auswählen
  - [ ] System zeigt eine Liste der Forscher, die in ALLEN ausgewählten Communities aktiv sind
  - [ ] Jedes Ergebnis zeigt den Forschernamen und die Communities, in denen er aktiv ist
  - [ ] Ergebnisse können nach Name oder Publikationsanzahl sortiert werden

---

## 8. Definition of Done (verpflichtend)

Eine User Story darf nur dann geschlossen werden, wenn ALLE folgenden Punkte erfüllt sind:

1. Alle Akzeptanzkriterien sind implementiert und getestet
2. OO-Entwurf: Model, View und Controller sind sinnvoll getrennt (Controller-Klassen klein halten!)
3. Unit-Tests mit hoher Branch-Coverage sind vorhanden
4. API-Dokumentation (Javadoc) ist vorhanden
5. Die Technische Schuld ist auf Basis der SonarQube-Ergebnisse sinnvoll reduziert (ab Release 2)
6. Merge Request ist genehmigt und gemerged

---

## 9. Planungsprozess

Für jedes Release:

1. User Stories verfeinern und Akzeptanzkriterien hinzufügen
2. Verantwortlichkeiten planen und in GitHub Projects dokumentieren
3. Implementierung über Feature-Branches — ein Merge Request pro User Story
4. Entwickeln → Commit/Push → Testen → Dokumentieren
5. Merge und Gesamttest des neuen Releases
6. Retrospektive: Was lief gut, was muss verbessert werden
7. Release in Git taggen (z.B. R1, R2, R3)

---

## 10. Tipps

- Beginnen Sie mit den SRs der Priorität "Muss" — sie bilden das Kernprodukt
- Jedes Teammitglied sollte mindestens eine US pro Release verantworten
- Schreiben Sie Akzeptanzkriterien, die konkret und testbar sind — vermeiden Sie vage Kriterien wie "funktioniert korrekt"
- Verwenden Sie GitHub Issue-Nummern in Commit-Nachrichten (#IssueNr)
- Halten Sie Ihr SonarQube-Dashboard ab Release 2 sauber
