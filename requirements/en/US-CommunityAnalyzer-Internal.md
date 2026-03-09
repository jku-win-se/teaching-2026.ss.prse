# Community Analyzer — Complete User Stories (Internal Reference)

**Usage:** Internal document for assistants (Luca Berardinelli, Abbas Rahimi)
**Do not distribute to students** — students must produce their own SR and US.

---

## BR-01: Create a New Community

**US-001: Create a new community**
- Linked BR: BR-01
- Milestone: Release 1
- Story: As a researcher, I want to create a new community with a name and description, so that I can organize conferences and journals around a research topic.
- Acceptance Criteria:
  - [ ] User can enter a community name (mandatory, unique, 3–100 chars) and optional description
  - [ ] Clicking "Create" persists the community (file or database)
  - [ ] The new community appears in the community list
  - [ ] Duplicate names are rejected with a meaningful error message
  - [ ] Empty or invalid names are rejected with a meaningful error message

---

## BR-02: Edit an Existing Community

**US-002: Edit an existing community**
- Linked BR: BR-02
- Milestone: Release 1
- Story: As a researcher, I want to edit a community's name and description, so that I can keep the community information up to date.
- Acceptance Criteria:
  - [ ] User can select a community from the list and click "Edit"
  - [ ] A form is pre-filled with the current name and description
  - [ ] Changes are persisted after clicking "Save"
  - [ ] Validation rules (unique name, length) still apply on edit
  - [ ] Cancel discards changes

---

## BR-03: Delete a Community

**US-003: Delete a community**
- Linked BR: BR-03
- Milestone: Release 1
- Story: As a researcher, I want to delete a community I no longer need, so that my workspace stays clean.
- Acceptance Criteria:
  - [ ] User can select a community and click "Delete"
  - [ ] A confirmation dialog asks "Are you sure?"
  - [ ] On confirm, the community and its assignments (conferences/journals) are removed
  - [ ] On cancel, nothing happens
  - [ ] Deleted community no longer appears in the list

---

## BR-04: Create, Edit, and Delete Conferences and Journals

**US-004: Create a conference**
- Linked BR: BR-04
- Milestone: Release 1
- Story: As a researcher, I want to create a new conference entry with name, abbreviation, and type, so that I can track publications in that venue.
- Acceptance Criteria:
  - [ ] User can enter conference name (mandatory), abbreviation, and type = "Conference"
  - [ ] Conference is persisted and visible in the venue list
  - [ ] Duplicate names/abbreviations within the same type are rejected

**US-005: Create a journal**
- Linked BR: BR-04
- Milestone: Release 1
- Story: As a researcher, I want to create a new journal entry, so that I can track journal publications separately from conferences.
- Acceptance Criteria:
  - [ ] User can enter journal name (mandatory), abbreviation, ISSN (optional), and type = "Journal"
  - [ ] Journal is persisted and visible in the venue list

**US-006: Edit a conference or journal**
- Linked BR: BR-04
- Milestone: Release 1
- Story: As a researcher, I want to edit an existing conference or journal, so that I can correct or update venue information.
- Acceptance Criteria:
  - [ ] User can select a venue and click "Edit"
  - [ ] Form is pre-filled with current data
  - [ ] Changes are validated and persisted

**US-007: Delete a conference or journal**
- Linked BR: BR-04
- Milestone: Release 1
- Story: As a researcher, I want to delete a conference or journal I no longer need.
- Acceptance Criteria:
  - [ ] User can select a venue and click "Delete"
  - [ ] Confirmation dialog is shown
  - [ ] On confirm, venue is removed along with its community assignments
  - [ ] Publications linked to this venue are flagged or handled gracefully

---

## BR-05: Each Community Can Have Multiple Conferences and Journals Assigned

**US-008: Assign venues to a community**
- Linked BR: BR-05
- Milestone: Release 1
- Story: As a researcher, I want to assign multiple conferences and journals to a community, so that the community reflects the relevant publication venues.
- Acceptance Criteria:
  - [ ] User can open a community and click "Assign Venues"
  - [ ] A list of available conferences and journals is shown (multi-select)
  - [ ] Selected venues are linked to the community
  - [ ] Already assigned venues are pre-checked

**US-009: Remove venue assignment from a community**
- Linked BR: BR-05
- Milestone: Release 1
- Story: As a researcher, I want to remove a venue from a community if it is no longer relevant.
- Acceptance Criteria:
  - [ ] User can uncheck a venue in the assignment view
  - [ ] The venue-community link is removed
  - [ ] The venue itself is not deleted, only the assignment

---

## BR-06: Conferences and Journals Can Have a Rating

**US-010: Assign a general rating to a venue**
- Linked BR: BR-06
- Milestone: Release 2
- Story: As a researcher, I want to assign a general rating (e.g., A*, A, B, C) to a conference or journal, so that I can assess venue quality.
- Acceptance Criteria:
  - [ ] User can select a venue and set a general rating from a predefined scale
  - [ ] Rating is persisted and displayed in the venue list
  - [ ] Rating can be updated or removed

**US-011: Assign a community-specific rating to a venue**
- Linked BR: BR-06
- Milestone: Release 2
- Story: As a researcher, I want to assign a community-specific rating to a venue, so that different communities can rate the same venue differently.
- Acceptance Criteria:
  - [ ] User can set a rating for a venue within the context of a specific community
  - [ ] Community-specific rating is displayed separately from the general rating
  - [ ] Both ratings coexist without conflict

---

## BR-07: Researchers Publish in Conferences and Journals

**US-012: View researcher publications**
- Linked BR: BR-07
- Milestone: Release 2
- Story: As a researcher, I want to see which researchers have published in which conferences and journals, so that I can understand publication patterns.
- Acceptance Criteria:
  - [ ] Selecting a venue shows a list of researchers who published there
  - [ ] Selecting a researcher shows a list of their publications with venue and year
  - [ ] Publication count per venue is displayed

**US-013: Link publications to researchers and venues**
- Linked BR: BR-07
- Milestone: Release 2
- Story: As a system, publications imported from DBLP are automatically linked to their respective researchers and venues.
- Acceptance Criteria:
  - [ ] After DBLP import, each publication is linked to its author(s) and venue
  - [ ] Researchers with the same name are handled (disambiguation or merge)
  - [ ] Venue matching uses DBLP key to identify conferences/journals

---

## BR-08: Base Data Can Be Imported from DBLP

**US-014: Import DBLP XML data**
- Linked BR: BR-08
- Milestone: Release 2
- Story: As a researcher, I want to import publication data from a DBLP XML file, so that I can populate the system with real-world research data.
- Acceptance Criteria:
  - [ ] User can select a DBLP XML file via file chooser
  - [ ] System parses using streaming (SAX/StAX) to handle large files (up to 4 GB)
  - [ ] Extracted data: author name(s), publication title, year, venue key
  - [ ] Import runs in a background thread — UI remains responsive
  - [ ] A progress indicator shows number of records processed
  - [ ] Success/failure message displayed at completion

**US-015: Filter DBLP import by venue subset**
- Linked BR: BR-08
- Milestone: Release 3
- Story: As a researcher, I want to import only data for specific conferences or journals from DBLP, so that I can focus on relevant venues without importing the entire dataset.
- Acceptance Criteria:
  - [ ] User can specify a list of venue keys or names before import
  - [ ] Only publications matching the specified venues are imported
  - [ ] Non-matching entries are skipped silently

---

## BR-09: Persons Are Displayed for a Community

**US-016: List researchers in a community**
- Linked BR: BR-09
- Milestone: Release 2
- Story: As a researcher, I want to see all persons who have published in venues assigned to a community, so that I can understand who is active in that research area.
- Acceptance Criteria:
  - [ ] Selecting a community shows a list of researchers
  - [ ] Researchers are determined by having at least one publication in an assigned venue
  - [ ] Each entry shows researcher name and publication count in that community
  - [ ] List is sortable by name and publication count

---

## BR-10: Load and Save Community Definitions to/from File

**US-017: Export a community definition to file**
- Linked BR: BR-10
- Milestone: Release 2
- Story: As a researcher, I want to export a community definition (name, description, assigned venues, ratings) to a file, so that I can back it up or share it.
- Acceptance Criteria:
  - [ ] User can select a community and click "Export"
  - [ ] A file chooser allows selecting the output path and format (JSON or XML)
  - [ ] The exported file contains: community metadata, venue assignments, ratings
  - [ ] File is human-readable

**US-018: Import a community definition from file**
- Linked BR: BR-10
- Milestone: Release 2
- Story: As a researcher, I want to import a community definition from a file, so that I can restore or share community configurations.
- Acceptance Criteria:
  - [ ] User can select a file via file chooser
  - [ ] System validates the file format before importing
  - [ ] Imported community appears in the list with all its venue assignments and ratings
  - [ ] Conflicts (e.g., duplicate community name) are handled with user prompt

---

## BR-11: Overlap of Communities

**US-019: Analyze community overlap**
- Linked BR: BR-11
- Milestone: Release 3
- Story: As a researcher, I want to see which researchers are active in two or more communities, so that I can identify interdisciplinary researchers.
- Acceptance Criteria:
  - [ ] User can select two or more communities for comparison
  - [ ] System displays a list of researchers active in ALL selected communities
  - [ ] Each result shows researcher name and the communities they belong to
  - [ ] Result count (number of overlapping researchers) is shown
  - [ ] Results can be sorted by name or publication count

---

## BR-12: Where Do Researchers Publish After Leaving a Community?

**US-020: Track researchers who left a community**
- Linked BR: BR-12
- Milestone: Release 3
- Story: As a researcher, I want to know where researchers who were previously active in a community now publish, so that I can track migration patterns.
- Acceptance Criteria:
  - [ ] User can select a community and define an "activity window" (e.g., no publications in last N years)
  - [ ] System identifies researchers who were active but are no longer publishing in that community
  - [ ] For each inactive researcher, the system shows their current publication venues
  - [ ] Results are sortable by researcher name, last active year, and current venue count

---

## BR-13: Journals and Conferences Can Be Filtered by Ratings

**US-021: Filter venues by rating**
- Linked BR: BR-13
- Milestone: Release 2
- Story: As a researcher, I want to filter the list of conferences and journals by rating, so that I can focus on high-quality venues.
- Acceptance Criteria:
  - [ ] A rating filter dropdown/checkbox is available in the venue list view
  - [ ] Selecting a rating (e.g., "A* only", "A and above") filters the displayed venues
  - [ ] Filter applies to both general and community-specific ratings (user selects which)
  - [ ] Clearing the filter shows all venues again

---

## BR-14: Persons Can Be Filtered by the Ratings of Their Publications

**US-022: Filter researchers by publication venue rating**
- Linked BR: BR-14
- Milestone: Release 3
- Story: As a researcher, I want to filter researchers based on the ratings of the venues where they publish, so that I can identify researchers who consistently publish in top venues.
- Acceptance Criteria:
  - [ ] A rating filter is available in the researcher list view
  - [ ] Selecting a minimum rating filters to researchers who have at least one publication in a venue with that rating or higher
  - [ ] Filter can be combined with community selection
  - [ ] Result count updates dynamically

---

## BR-15: Conferences and Journals Can Be Sorted by Rating

**US-023: Sort venues by rating**
- Linked BR: BR-15
- Milestone: Release 2
- Story: As a researcher, I want to sort conferences and journals by their rating, so that I can quickly see the highest-ranked venues.
- Acceptance Criteria:
  - [ ] Clicking the "Rating" column header sorts venues ascending/descending
  - [ ] Sort works for both general and community-specific ratings
  - [ ] Venues without a rating are placed at the bottom

---

## BR-16: Persons Can Be Sorted by Research Output (Count)

**US-024: Sort researchers by publication count**
- Linked BR: BR-16
- Milestone: Release 2
- Story: As a researcher, I want to sort researchers by the number of publications, so that I can identify the most prolific contributors.
- Acceptance Criteria:
  - [ ] Clicking the "Publications" column header sorts researchers ascending/descending
  - [ ] Count reflects publications in the selected community's venues (if a community is selected)
  - [ ] Count reflects all publications if no community filter is active

---

## BR-17: Persons Can Be Sorted by Research Output (Weighted)

**US-025: Sort researchers by weighted research output**
- Linked BR: BR-17
- Milestone: Release 3
- Story: As a researcher, I want to sort researchers by a weighted score that considers both publication count and venue ratings, so that I can assess research impact more accurately.
- Acceptance Criteria:
  - [ ] A "Weighted Score" column is available in the researcher list
  - [ ] Score formula: sum of (rating weight × publications in that venue) per researcher
  - [ ] Rating weights are configurable (e.g., A*=4, A=3, B=2, C=1, unrated=0)
  - [ ] Clicking the column header sorts by weighted score ascending/descending
  - [ ] Tooltip or help text explains the scoring formula

---

## BR-18: Ratings for Conferences Can Be Automatically Imported

**US-026: Import conference ratings from GII-GRIN-SCIE**
- Linked BR: BR-18
- Milestone: Release 3
- Story: As a researcher, I want to automatically import conference ratings from the GII-GRIN-SCIE database, so that I don't have to enter them manually.
- Acceptance Criteria:
  - [ ] User can trigger "Import Conference Ratings" from the menu
  - [ ] System fetches data from http://gii-grin-scie-rating.scie.es/ (web scraping or API)
  - [ ] Imported ratings are matched to existing conferences by name or abbreviation
  - [ ] Matched ratings are applied as general ratings
  - [ ] Unmatched conferences are listed in a report for manual review
  - [ ] Import progress and result summary are displayed

---

## BR-19: Ratings for Journals Can Be Automatically Imported

**US-027: Import journal ratings from external source**
- Linked BR: BR-19
- Milestone: Release 3
- Story: As a researcher, I want to automatically import journal ratings from an external source, so that I don't have to enter them manually.
- Acceptance Criteria:
  - [ ] User can trigger "Import Journal Ratings" from the menu
  - [ ] System supports at least one journal rating source (e.g., SJR, JCR, or a CSV upload)
  - [ ] Imported ratings are matched to existing journals by name or ISSN
  - [ ] Matched ratings are applied as general ratings
  - [ ] Unmatched journals are listed for manual review
  - [ ] Import progress and result summary are displayed

---

## BR-20: Graphical Evaluation and Presentation of Analysis Results

**US-028: Display community statistics as charts**
- Linked BR: BR-20
- Milestone: Release 3
- Story: As a researcher, I want to see graphical reports about a community (e.g., publication trends, venue distribution), so that I can quickly understand research patterns.
- Acceptance Criteria:
  - [ ] User can open a "Reports" view for a selected community
  - [ ] At least 3 chart types are available (e.g., bar chart, pie chart, line chart)
  - [ ] Bar chart: publications per year
  - [ ] Pie chart: distribution of publications across venues
  - [ ] Line chart: publication trend over time
  - [ ] Charts update when the underlying data changes

**US-029: Export reports**
- Linked BR: BR-20
- Milestone: Release 3
- Story: As a researcher, I want to export graphical reports as PDF or images, so that I can include them in presentations or documents.
- Acceptance Criteria:
  - [ ] User can click "Export" on any chart view
  - [ ] Export formats: PNG and/or PDF
  - [ ] Exported file includes chart title, date, and community name
  - [ ] File chooser allows selecting output location

---

## Summary: User Stories per Release

| Release | User Stories | BRs Covered |
|---------|-------------|-------------|
| Release 1 | US-001 – US-009 | BR-01, BR-02, BR-03, BR-04, BR-05 |
| Release 2 | US-010 – US-018, US-021, US-023, US-024 | BR-06, BR-07, BR-08, BR-09, BR-10, BR-13, BR-15, BR-16 |
| Release 3 | US-019, US-020, US-022, US-025 – US-029 | BR-11, BR-12, BR-14, BR-17, BR-18, BR-19, BR-20 |

| Totals | |
|--------|---|
| Business Requirements | 20 (BR-01 – BR-20) |
| User Stories | 29 |
