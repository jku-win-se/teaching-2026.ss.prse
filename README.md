# Praktikum Software Engineering — SS 2026

**Institute:** Institut für Wirtschaftsinformatik — Software Engineering, JKU Linz
**Course Director:** Univ.-Prof. Dr. Manuel Wimmer
**Assistants:** Luca Berardinelli, Abbas Rahimi
**Contact:** luca.berardinelli@jku.at

---

## Project: Community Analyzer

Your team will develop a **Community Analyzer** application that analyzes research communities using publication data from [DBLP](https://dblp.uni-trier.de/xml). The application allows users to create communities, assign conferences and journals, import researcher data, and perform analyses such as community overlap and publication trend reporting.

See [requirements/en/BR-CommunityAnalyzer.md](requirements/en/BR-CommunityAnalyzer.md) for the full list of 20 Business Requirements (BR-01 to BR-20).

---

## Repository Structure

```
teaching-2026.ss.prse/
├── requirements/
│   └── en/
│       ├── BR-CommunityAnalyzer.md         # Business Requirements (BR-01 to BR-20)
│       └── BR-SR-US-Guide-Students.md      # How to refine BRs into SRs and User Stories
├── slides/
│   └── SE Praktikum-2026.pdf               # Course presentation slides
├── tools/
│   ├── Tool-Guide.md                       # All course tools with descriptions and links
│   ├── Installation-Guide-Windows.md       # Step-by-step setup for Windows
│   ├── Installation-Guide-macOS.md         # Step-by-step setup for macOS
│   └── Installation-Guide-Linux.md         # Step-by-step setup for Linux
└── README.md                               # This file
```

---

## Getting Started

### 1. Set Up Your Environment

Follow the installation guide for your operating system:

- [Windows](tools/Installation-Guide-Windows.md)
- [macOS](tools/Installation-Guide-macOS.md)
- [Linux](tools/Installation-Guide-Linux.md)

All guides cover: Java 21, Maven, JavaFX, SceneBuilder, Git, VS Code, SonarQube, JaCoCo, and more. See [tools/Tool-Guide.md](tools/Tool-Guide.md) for a complete overview of all tools.

### 2. Form Your Team

- Teams of **3 students**
- One team member acts as "Team Leader"
- Send an email to **luca.berardinelli@jku.at** with subject **PR_SE2026 Team** containing: Name, Matr.Nr, email, and GitHub username for each member

### 3. Create Your Team Repository

Each team creates their own **private GitHub repository** for the project. Your repository should include:

- A Maven project with Java 21 and JavaFX 23.0.2
- JaCoCo plugin for code coverage
- A `.github/workflows/ci.yml` for GitHub Actions CI/CD
- A `docker/` folder with SonarQube local setup (see setup project below)

Use the [se-praktikum-setup](https://github.com/lberardinelli/se-praktikum-setup) repository as a reference for the project structure, Maven configuration, CI/CD pipeline, and SonarQube Docker setup.

### 4. Read the Requirements

- [BR-CommunityAnalyzer.md](requirements/en/BR-CommunityAnalyzer.md) — the 20 Business Requirements
- [BR-SR-US-Guide-Students.md](requirements/en/BR-SR-US-Guide-Students.md) — how to refine BRs into Software Requirements and User Stories, with examples

Not all BRs must be implemented. Choose a meaningful subset for your team's budget of **450 hours** (150h × 3 students).

### 5. Plan Your First Release

Use **GitHub Projects** to plan your work:

1. Create Software Requirements from the selected BRs
2. Create User Stories with Acceptance Criteria
3. Assign each User Story to a team member and a release milestone
4. Complete planning by the Sprint Planning deadline (see schedule below)

---

## Tech Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| Language | Java | 21 (LTS) |
| UI Framework | JavaFX | 23.0.2 |
| UI Design | SceneBuilder | 23.0.1 (mandatory) |
| Build | Maven | 3.9+ |
| Testing | JUnit 5 | 5.11+ |
| Code Coverage | JaCoCo | 0.8.12 |
| Code Quality | SonarQube Community + SonarLint | latest |
| CI/CD | GitHub Actions | — |
| Project Management | GitHub Projects | — |
| Storage | File-based or PostgreSQL 16 | team's choice |

---

## Schedule

| Date | Day | Event |
|------|-----|-------|
| 10.03.2026 | Tue | Instructions |
| 17.03.2026 | Tue | Requirements Workshop + Sprint Planning 1 |
| 21.03.2026 | Sat | Sprint Planning 1 completed in GitHub Projects |
| 24.03.2026 | Tue | Project Meeting (individual teams) |
| **11.04.2026** | **Sat** | **Release 1 (R1)** |
| 14.04.2026 | Tue | Release 1 Review + Sprint Planning 2 |
| 05.05.2026 | Tue | Project Meeting (individual teams) |
| **16.05.2026** | **Sat** | **Release 2 (R2)** |
| 19.05.2026 | Tue | Release 2 Review + Sprint Planning 3 |
| 02.06.2026 | Tue | Project Meeting (Code Review) |
| **27.06.2026** | **Sat** | **Release 3 (R3)** |
| 30.06.2026 | Tue | Final Sprint Planning + Final Presentation |
| **13.07.2026** | **Mon** | **Final Release + Final Documentation** |

---

## Releases

### Release 1 — UI Prototype and OO Design (11.04.2026)

- First concept for the application (features, components)
- UML Class Diagram with the most important classes (using a UML tool)
- Entity Relationship Diagram (if PostgreSQL is chosen)
- UI Prototype (JavaFX / SceneBuilder)
- Continuous Integration with GitHub Actions

### Release 2 — Prototype Implementation and Unit Tests (16.05.2026)

- Extended/updated UML Diagrams
- Prototype implementation with first working functionality
- Unit Tests for important classes
- User Stories with Acceptance Criteria (linked to Software Requirements)
- Code Quality Report (present max. 2 fixes proposed by SonarQube)

### Release 3 — Documentation (27.06.2026)

- Extended Unit Tests (≥ 85% branch coverage for non-UI code)
- Most functionalities implemented
- Final Code Quality Report (SonarQube)
- Technical debt reduced based on SonarQube findings
- Live Demo / Screencast of the application

### Final Submission (13.07.2026)

- Final project documentation
- Executable application on GitHub main branch, tagged
- README with installation instructions
- Javadoc for important classes, interfaces, and methods
- All User Stories closed with Definition of Done satisfied

---

## Development Workflow

```
1. Pick a User Story from GitHub Projects
2. Create a feature branch:  git checkout -b feature/US-001-create-community
3. Implement + write unit tests
4. Run locally:  mvn clean verify
5. Check coverage:  open target/site/jacoco/index.html
6. Commit with issue reference:  git commit -m "Implement community creation #1"
7. Push and create a Pull Request
8. CI runs automatically → review → merge
9. Close the User Story when Definition of Done is met
```

### Definition of Done

A User Story may only be closed when ALL of the following are met:

1. All Acceptance Criteria are implemented and tested
2. OO Design: Model, View, Controller properly separated (keep Controllers small)
3. Unit Tests with high branch coverage are present
4. API Documentation (Javadoc) is present
5. Technical debt reduced based on SonarQube findings (from Release 2 onwards)
6. Merge Request approved and merged

### Rules

- Merge Request per User Story is **mandatory**
- Code must be committed at least **once per week**
- Always reference issue numbers in commits (`#IssueNr`)
- Tag each release in Git (R1, R2, R3)
- Each release submitted as a separate Git branch

---

## Evaluation

| Criterion | Details |
|-----------|---------|
| Functionality | Does the product work as specified? |
| External Quality | Stability, efficiency, user interface |
| Internal Quality | OO design, MVC separation, programming quality, Javadoc, SonarQube technical debt |
| Unit Tests | ≥ 85% branch coverage for non-UI code, quality of tests |
| Documentation | Design documents, test cases, experience report |
| Process Quality | GitHub Projects usage, Merge Requests, commit discipline, Definition of Done |
| Presentations | Sprint review presentations (each member participates) |

---

## Data Sources

| Source | URL | Used for |
|--------|-----|----------|
| DBLP XML | https://dblp.uni-trier.de/xml | Importing publication data (BR-08) |
| GII-GRIN-SCIE | http://gii-grin-scie-rating.scie.es/ | Conference ratings (BR-18) |
| Journal Ratings | Team's choice (e.g., SJR, JCR, CSV) | Journal ratings (BR-19) |

---

## Questions and Announcements

| Channel | Purpose |
|---------|---------|
| **Moodle Q&A Forum** | Ask questions (follow [StackOverflow guidelines](https://stackoverflow.com/help/how-to-ask)) |
| **Moodle News Forum** | Course announcements |
| **luca.berardinelli@jku.at** | Team registration and organizational matters |

---

## Useful Links

| Resource | Link |
|----------|------|
| SonarQube Documentation | https://docs.sonarsource.com/sonarqube-community-build/ |
| GitHub Actions Documentation | https://docs.github.com/en/actions |
| JavaFX / SceneBuilder | https://openjfx.io/ |
| Git Tutorial (German) | https://rogerdudler.github.io/git-guide/index.de.html |
| Setup Verification Project | https://github.com/lberardinelli/se-praktikum-setup |
