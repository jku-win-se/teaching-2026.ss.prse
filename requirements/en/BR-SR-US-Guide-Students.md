# Community Analyzer — From Business Requirements to User Stories

## A Guide for Students

**Course:** Praktikum Software Engineering — SS 2026

This document explains how to refine Business Requirements (BR) into Software Requirements (SR) and User Stories (US). It provides concrete examples from the Community Analyzer project.

---

## 1. The Refinement Chain

```
Business Requirement (BR)    — What the client wants (high-level)
  └→ Software Requirement (SR)  — How we specify it technically (measurable, verifiable)
      └→ User Story (US)          — How we implement it in a sprint (testable)
          └→ Acceptance Criteria    — How we verify it's done
```

**Key rules:**
- One BR can generate multiple SRs
- One SR can generate one or more USs
- A US can be linked to multiple SRs (only if it truly makes sense)
- Not all BRs must be implemented — choose a meaningful subset for your budget (450 hours)

---

## 2. Naming Conventions

| Level | Format | Example |
|-------|--------|---------|
| Business Requirement | BR-NN | BR-08 |
| Software Requirement | SR-NN.X | SR-08.1, SR-08.2 |
| User Story | US-NNN | US-001, US-002 |

---

## 3. Software Requirement Template

```markdown
### SR-NN.X: [Title]

**Linked BR:** BR-NN
**Priority:** Must / Should / Could
**Description:** The system shall [measurable behavior].
**Constraints:** [Technical constraints, formats, limits]
**Verification:** [How to verify this requirement is met]
```

---

## 4. User Story Template

```markdown
### US-NNN: [Title]

**Linked SR:** SR-NN.X, SR-NN.Y
**Assignee:** [Team member]
**Milestone:** Release N
**Story:** As a [role], I want [goal], so that [benefit].

**Acceptance Criteria:**
- [ ] [Criterion 1 — testable]
- [ ] [Criterion 2 — testable]
- [ ] [Criterion 3 — testable]
```

---

## 5. Example: BR-01 (Create Community)

### Business Requirement

> **BR-01:** Create a new community (name, description, …)

### Software Requirements

**SR-01.1: Create Community with required fields**
- Linked BR: BR-01
- Priority: Must
- Description: The system shall allow the user to create a new community by providing a name (mandatory, unique) and a description (optional).
- Constraints: Community name must be between 3 and 100 characters. No duplicate names allowed.
- Verification: Attempt to create a community with valid data → community is persisted and visible in the list.

**SR-01.2: Validate community creation input**
- Linked BR: BR-01
- Priority: Must
- Description: The system shall validate all input fields before creating a community and display meaningful error messages for invalid input.
- Constraints: Empty name, duplicate name, name exceeding 100 characters must be rejected.
- Verification: Attempt to create a community with empty name → error message displayed, community not created.

### User Stories

**US-001: Create a new community**
- Linked SR: SR-01.1
- Milestone: Release 1
- Story: As a researcher, I want to create a new community with a name and description, so that I can start organizing conferences and journals around a research topic.
- Acceptance Criteria:
  - [ ] User can enter a community name and optional description in a form
  - [ ] Clicking "Create" persists the community
  - [ ] The new community appears in the community list
  - [ ] Community name must be unique

**US-002: Validate community input**
- Linked SR: SR-01.2
- Milestone: Release 1
- Story: As a user, I want to see clear error messages when I provide invalid input, so that I can correct my data before submitting.
- Acceptance Criteria:
  - [ ] Empty name shows error "Community name is required"
  - [ ] Duplicate name shows error "A community with this name already exists"
  - [ ] Name longer than 100 characters shows error "Name must not exceed 100 characters"

---

## 6. Example: BR-08 (DBLP Import)

### Business Requirement

> **BR-08:** Base data can be imported from DBLP (XML, available at: https://dblp.uni-trier.de/xml)

### Software Requirements

**SR-08.1: Parse DBLP XML files**
- Linked BR: BR-08
- Priority: Must
- Description: The system shall parse DBLP XML files using a streaming parser (SAX or StAX) to handle large files efficiently.
- Constraints: Must handle files up to at least 4 GB. Must not load entire file into memory.
- Verification: Import a large DBLP XML file → import completes without OutOfMemoryError.

**SR-08.2: Extract publication metadata**
- Linked BR: BR-08
- Priority: Must
- Description: The system shall extract the following fields from DBLP entries: author name(s), publication title, year, venue (conference or journal key).
- Constraints: Publications without a year or without authors may be skipped with a warning.
- Verification: Import a sample DBLP file → verify extracted data matches expected values for known publications.

**SR-08.3: Show import progress**
- Linked BR: BR-08
- Priority: Should
- Description: The system shall display a progress indicator during DBLP import showing at minimum the number of records processed.
- Constraints: UI must remain responsive during import (background thread).
- Verification: Start import → progress indicator updates, UI does not freeze.

### User Stories

**US-010: Import DBLP XML data**
- Linked SR: SR-08.1, SR-08.2
- Milestone: Release 2
- Story: As a researcher, I want to import publication data from a DBLP XML file, so that I can populate my community with real-world research data.
- Acceptance Criteria:
  - [ ] User can select a DBLP XML file via file chooser dialog
  - [ ] Import extracts author, title, year, venue for each publication
  - [ ] Import completes without error for files up to 4 GB
  - [ ] Imported data is visible in the application after import

**US-011: Show import progress**
- Linked SR: SR-08.3
- Milestone: Release 2
- Story: As a user, I want to see import progress, so that I know the import is working and can estimate how long it will take.
- Acceptance Criteria:
  - [ ] A progress bar or counter is displayed during import
  - [ ] The UI remains responsive (not frozen) during import
  - [ ] A success message appears when import completes

---

## 8. Definition of Done (mandatory)

A User Story may only be closed when ALL of the following are met:

1. All Acceptance Criteria are implemented and tested
2. OO Design: Model, View, Controller are properly separated (keep Controllers small!)
3. Unit Tests with high branch coverage are present
4. API Documentation (Javadoc) is present
5. Technical debt is reduced based on SonarQube findings (from Release 2 onwards)
6. Merge Request is approved and merged

---

## 9. Planning Process

For each release:

1. Refine User Stories and add Acceptance Criteria
2. Plan responsibilities and document in GitHub Projects
3. Implement via feature branches — one Merge Request per User Story
4. Develop → Commit/Push → Test → Document
5. Merge and integration test of the new release
6. Retrospective: what went well, what to improve
7. Tag the release in Git (e.g., R1, R2, R3)

---

## 10. Tips

- Start with the "Must" priority SRs — they form the core product
- Each team member should own at least one US per release
- Write Acceptance Criteria that are concrete and testable — avoid vague criteria like "works correctly"
- Use GitHub issue numbers in commit messages (#IssueNr)
- Keep your SonarQube dashboard clean from Release 2 onwards
