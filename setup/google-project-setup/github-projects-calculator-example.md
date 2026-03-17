# GitHub Projects — Calculator Example

This document demonstrates how to structure **Requirements**, **User Stories**, and **Acceptance Criteria** for a simple Calculator application, organized across **3 releases + 1 final release**.

---

## Release Plan

| Release | Date | Focus | Scope |
|---------|------|-------|-------|
| **R1** | Week 4 | Core MVP | Basic operations + validation |
| **R2** | Week 8 | Display | Number formatting + overflow handling |
| **R3** | Week 12 | UX Polish | History + keyboard support |
| **Final** | Week 14 | Integration | Testing, docs, deployment |

---

## Overview

| Artifact | Purpose | GitHub Projects Item Type |
|----------|---------|---------------------------|
| **Business Requirement (BR)** | What the system must do (stakeholder perspective) | Issue with label `requirement` |
| **User Story (US)** | How a user interacts with a feature | Issue with label `user-story` |
| **Acceptance Criteria (AC)** | Testable conditions for "done" | Checklist within User Story |

---

## Requirements (BR-01 to BR-05)

### BR-01: Basic Arithmetic Operations

| Field | Value |
|-------|-------|
| **ID** | BR-01 |
| **Title** | Basic Arithmetic Operations |
| **Description** | The calculator shall perform addition, subtraction, multiplication, and division on two numeric operands. |
| **Rationale** | Core functionality expected from any calculator application. |
| **Priority** | Must Have |
| **Release** | R1 |

---

### BR-02: Input Validation

| Field | Value |
|-------|-------|
| **ID** | BR-02 |
| **Title** | Input Validation |
| **Description** | The calculator shall validate user input and provide meaningful error messages for invalid entries (e.g., non-numeric input, division by zero). |
| **Rationale** | Prevents application crashes and improves user experience. |
| **Priority** | Must Have |
| **Release** | R1 |

---

### BR-03: Calculation History

| Field | Value |
|-------|-------|
| **ID** | BR-03 |
| **Title** | Calculation History |
| **Description** | The calculator shall maintain a history of the last 10 calculations performed during the current session. |
| **Rationale** | Allows users to review and reuse previous results. |
| **Priority** | Should Have |
| **Release** | R3 |

---

### BR-04: Keyboard Support

| Field | Value |
|-------|-------|
| **ID** | BR-04 |
| **Title** | Keyboard Support |
| **Description** | The calculator shall support keyboard input for digits (0-9), operators (+, -, *, /), Enter (equals), and Escape (clear). |
| **Rationale** | Improves efficiency for power users. |
| **Priority** | Should Have |
| **Release** | R3 |

---

### BR-05: Responsive Display

| Field | Value |
|-------|-------|
| **ID** | BR-05 |
| **Title** | Responsive Display |
| **Description** | The calculator display shall show the current input, selected operator, and result with appropriate formatting (max 12 digits, scientific notation for overflow). |
| **Rationale** | Ensures readability and prevents UI overflow. |
| **Priority** | Must Have |
| **Release** | R2 |

---

## User Stories by Release

### Release 1 — Core MVP

#### US-01: Perform Addition (implements BR-01)

**As a** user  
**I want to** add two numbers together  
**So that** I can quickly calculate sums without mental arithmetic

##### Acceptance Criteria

- [ ] **AC-01.1**: Given the calculator is in initial state, when I enter "5", press "+", enter "3", and press "=", then the display shows "8"
- [ ] **AC-01.2**: Given a previous result is displayed, when I press an operator, then the previous result becomes the first operand
- [ ] **AC-01.3**: Given I enter decimal numbers "2.5 + 1.5", when I press "=", then the display shows "4"
- [ ] **AC-01.4**: Given I enter negative numbers "-5 + 3", when I press "=", then the display shows "-2"

**Labels**: `user-story`, `priority:must-have`, `release:R1`  
**Linked Requirement**: BR-01

---

#### US-02: Handle Division by Zero (implements BR-02)

**As a** user  
**I want to** receive a clear error message when dividing by zero  
**So that** I understand why the operation failed

##### Acceptance Criteria

- [ ] **AC-02.1**: Given I enter "10 / 0", when I press "=", then the display shows "Error: Division by zero"
- [ ] **AC-02.2**: Given an error is displayed, when I press "C" (clear), then the calculator resets to initial state
- [ ] **AC-02.3**: Given an error is displayed, when I enter a new digit, then the error clears and the new digit is shown

**Labels**: `user-story`, `priority:must-have`, `release:R1`  
**Linked Requirement**: BR-02

---

### Release 2 — Display

#### US-05: Display Large Results (implements BR-05)

**As a** user  
**I want to** see large numbers formatted appropriately  
**So that** I can read results that exceed the display width

##### Acceptance Criteria

- [ ] **AC-05.1**: Given I calculate "999999999999 * 2", when the result is displayed, then it shows in scientific notation "2.0E12"
- [ ] **AC-05.2**: Given I calculate "1 / 3", when the result is displayed, then it shows max 12 significant digits "0.333333333333"
- [ ] **AC-05.3**: Given the result is "12345", when displayed, then no scientific notation is used
- [ ] **AC-05.4**: Given the result is negative and large "-1.5E15", when displayed, then the minus sign is included

**Labels**: `user-story`, `priority:must-have`, `release:R2`  
**Linked Requirement**: BR-05

---

### Release 3 — UX Polish

#### US-03: View Calculation History (implements BR-03)

**As a** user  
**I want to** see my recent calculations  
**So that** I can verify my work or reuse a previous result

##### Acceptance Criteria

- [ ] **AC-03.1**: Given I have performed 3 calculations, when I open the history panel, then I see all 3 calculations in reverse chronological order
- [ ] **AC-03.2**: Given the history contains 10 entries, when I perform an 11th calculation, then the oldest entry is removed
- [ ] **AC-03.3**: Given I click on a history entry "5 + 3 = 8", when I select it, then "8" is loaded as the current operand
- [ ] **AC-03.4**: Given I close and reopen the application, when I check history, then the history is empty (session-only)

**Labels**: `user-story`, `priority:should-have`, `release:R3`  
**Linked Requirement**: BR-03

---

#### US-04: Use Keyboard for Input (implements BR-04)

**As a** power user  
**I want to** use my keyboard to enter calculations  
**So that** I can work faster without switching to the mouse

##### Acceptance Criteria

- [ ] **AC-04.1**: Given the calculator has focus, when I press "7", then "7" appears in the display
- [ ] **AC-04.2**: Given I have entered "5", when I press "+", then the operator indicator shows "+"
- [ ] **AC-04.3**: Given I have entered "5 + 3", when I press "Enter", then the result "8" is displayed
- [ ] **AC-04.4**: Given any state, when I press "Escape", then the calculator resets to initial state
- [ ] **AC-04.5**: Given the calculator has focus, when I press an unsupported key (e.g., "a"), then nothing happens (no error)

**Labels**: `user-story`, `priority:should-have`, `release:R3`  
**Linked Requirement**: BR-04

---

### Final Release — Integration

| Task | Description |
|------|-------------|
| Integration testing | End-to-end tests across all features |
| Documentation | User guide, README, Javadoc |
| Code quality | SonarQube issues resolved, coverage >= 70% |
| Demo preparation | Presentation slides, live demo script |

---

## GitHub Projects Setup

### 1. Create Labels (GitHub Web UI)

Navigate to your repository → **Issues → Labels → New label** and create the following labels manually:

#### Type labels

| Label name | Color | Description |
|---|---|---|
| `requirement` | `#0052CC` | Business requirement |
| `user-story` | `#1D76DB` | User story |

#### Priority labels

| Label name | Color | Description |
|---|---|---|
| `priority:must-have` | `#B60205` | Must have priority |
| `priority:should-have` | `#FBCA04` | Should have priority |

#### Release labels

| Label name | Color | Description |
|---|---|---|
| `release:R1` | `#5319E7` | Release 1 — Core MVP |
| `release:R2` | `#7B61FF` | Release 2 — Display |
| `release:R3` | `#A78BFA` | Release 3 — UX Polish |
| `release:Final` | `#22C55E` | Final Release |

---

### 2. Create Milestones (GitHub Web UI)

Navigate to your repository → **Issues → Milestones → New milestone** and create the following:

| Title | Due date | Description |
|---|---|---|
| `R1 - Core MVP` | 2026-04-11 | Basic arithmetic + validation |
| `R2 - Display` | 2026-05-16 | Number formatting |
| `R3 - UX Polish` | 2026-06-27 | History + keyboard |
| `Final Release` | 2026-07-13 | Integration, docs, demo |

---

### 3. Configure Project Custom Fields

Navigate to your **GitHub Project → Settings → Custom fields** and create the following fields:

| Field Name | Type | Options |
|------------|------|---------|
| `Priority` | Single select | Must Have, Should Have |
| `Release` | Single select | R1, R2, R3, Final |
| `Status` | Single select | Backlog, To Do, In Progress, In Review, Done |

> **Note — Status values are fully custom:** The `Status` field has no fixed values imposed by GitHub. The five values above (`Backlog`, `To Do`, `In Progress`, `In Review`, `Done`) must be created manually by each student in **Project → Settings → Custom fields → Status**. GitHub only provides `Todo`, `In Progress`, and `Done` as defaults when using a built-in Kanban template — any additional values must be added explicitly.
>
> GitHub also uses a special implicit group called **"No Status"** for items that have not yet been assigned a Status value. This group is not a selectable value — it disappears as soon as all items have a Status assigned. The automation in Step 3 (`Item added to project → Backlog`) prevents issues from landing in "No Status" by assigning `Backlog` automatically on creation.

---

### 4. Configure Board View — Columns

GitHub Projects does **not** create board columns automatically. Columns appear only when the Board view is explicitly grouped by the `Status` field. Follow these steps:

**Step 1 — Open or create a Board view**

1. Open your GitHub Project
2. Click **+ New view** (tab bar at the top)
3. Select **Board** as the layout
4. Rename the view to `Board` (double-click the tab label)

**Step 2 — Group by Status**

1. Click the **▼** (view options) button in the top-right of the board
2. Select **Group by**
3. Choose **Status**

The five columns will now appear, one per `Status` value defined in §3:

| # | Column | Status value | Purpose |
|---|---|---|---|
| 1 | 📋 **Backlog** | `Backlog` | All items not yet scheduled for a release |
| 2 | 🎯 **To Do** | `To Do` | Planned for the current release, not yet started |
| 3 | 🔧 **In Progress** | `In Progress` | Actively being worked on |
| 4 | 👀 **In Review** | `In Review` | PR opened, awaiting feedback or approval |
| 5 | ✅ **Done** | `Done` | Completed and accepted (PR merged / issue closed) |

> **Important:** Items added to the project without a Status value will appear in a **"No Status"** group, not in Backlog. Use the automation below to assign `Backlog` automatically on creation.

**Step 3 — Enable Automations**

Navigate to **Project → Settings → Workflows** and enable:

| Trigger | Action |
|---|---|
| *Item added to project* | Set Status → `Backlog` |
| *Pull request opened* | Set Status → `In Review` |
| *Pull request merged* | Set Status → `Done` |
| *Issue closed* | Set Status → `Done` |

---

## Traceability Matrix

| Requirement | User Story | Priority | Release |
|-------------|------------|----------|---------|
| BR-01 | US-01 | Must Have | R1 |
| BR-02 | US-02 | Must Have | R1 |
| BR-05 | US-05 | Must Have | R2 |
| BR-03 | US-03 | Should Have | R3 |
| BR-04 | US-04 | Should Have | R3 |

---

## Issue Templates

### Why `.github/ISSUE_TEMPLATE/`?

The `.github/` directory is a **special folder recognized by GitHub at the platform level**. Files placed inside it activate native GitHub features without any plugin or configuration.

When one or more `.md` files exist under `.github/ISSUE_TEMPLATE/`, GitHub changes the behavior of the **"New issue"** button: instead of opening a blank text area, it presents a **template selection screen**:

```
┌─────────────────────────────────────────┐
│  Choose a template                      │
│                                         │
│  📄 Business Requirement  [Get started] │
│  📄 User Story            [Get started] │
│                                         │
│                  [Open a blank issue]   │
└─────────────────────────────────────────┘
```

Selecting a template pre-fills the issue form with the template content. The **YAML frontmatter** block at the top of each file controls the metadata:

```yaml
---
name: User Story           # label shown in the selection screen
about: Define a user story # short description shown below the name
title: "[US-XX] "          # pre-filled value in the Title field
labels: user-story         # label applied automatically on creation
---
```

| Without templates | With templates |
|---|---|
| Blank text area on new issue | Template selection screen |
| Labels must be set manually | Labels applied automatically via frontmatter |
| Free-form structure | Pre-filled structure (AC checklist, linked BR) |
| Risk of inconsistent issues | Consistent format across all students |

> **Note:** If only **one** template file exists, GitHub skips the selection screen and opens it directly. With **two or more** files the selection screen always appears.

---

### Setup Instructions for Student Repositories

Each student repository must contain the following directory structure:

```
<your-repo>/
└── .github/
    └── ISSUE_TEMPLATE/
        ├── requirement.md
        └── user-story.md
```

**Steps:**

1. In your repository root, create the folder `.github/ISSUE_TEMPLATE/` (both folder names are case-sensitive on GitHub)
2. Copy the two template files below into that folder
3. Commit and push to `main`
4. Verify by navigating to **Issues → New issue** in the GitHub web UI — the selection screen should appear

> The `.github/` folder and its contents are **committed to the repository** like any other file. They are version-controlled and shared across all collaborators.

---

### `.github/ISSUE_TEMPLATE/requirement.md`

```markdown
---
name: Business Requirement
about: Define a business requirement
title: "[BR-XX] "
labels: requirement
---

| Field | Value |
|-------|-------|
| **ID** | BR-XX |
| **Title** |  |
| **Description** |  |
| **Rationale** |  |
| **Priority** | Must Have / Should Have |
| **Release** | R1 / R2 / R3 |
```

### `.github/ISSUE_TEMPLATE/user-story.md`

```markdown
---
name: User Story
about: Define a user story with acceptance criteria
title: "[US-XX] "
labels: user-story
---

**As a** [role]  
**I want to** [action]  
**So that** [benefit]

## Acceptance Criteria

- [ ] **AC-XX.1**: Given [context], when [action], then [outcome]
- [ ] **AC-XX.2**: Given [context], when [action], then [outcome]

## Linked Requirement
BR-XX

## Release
R1 / R2 / R3
```

---

*Template version: 1.1 — SE-Praktikum SS 2026*
