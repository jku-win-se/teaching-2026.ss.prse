# Slide 1

![JKU Logo]

**JOHANNES KEPLER UNIVERSITY LINZ**

---

# Slide 2

**Institut fuer Wirtschaftsinformatik**
**Software Engineering**

# Praktikum Software Engineering

Manuel Wimmer, Luca Berardinelli, Abbas Rahimi

Unit 0 - Introduction & Preliminary Discussion

![JKU Logo]

---

# Slide 3 — Agenda

- Introduction
- Grouping
- Evaluation
- Tools
- Task assignment for Workshop on 17.03.2026

---

# Slide 4 — Goal of the Internship

- Development of an application in a team
  - Specify, plan and design a software product
  - Object-oriented programming and Testing (Unit tests & Code quality)
  - Teamwork
  - Application of SE tools
    - Version management (Repositories, GitHub)
    - Project management (GitHub Projects)
    - Build / Continuous Delivery (Maven + GitHub Actions)
    - Code Quality (SonarQube, SonarLint, JaCoCo)
  - Planning of the Sprints and Release Versions (GitHub Projects + Git branches)
  - Creation of System (Architecture, Code, Test cases, Documentation)

---

# Slide 5 — Topic: Community Analyzer

## Development of a Community Analyzer Application

A team of three developers should implement this project in several sprints over a period of 4 months creating all the necessary artifacts, such as: Software, Tests, Documentation, etc.

The application analyzes research communities using data from DBLP (https://dblp.uni-trier.de/xml).

- Create, Read, Update and Delete communities, conferences, and journals (CRUD operations)
- Import base data from DBLP (XML)
- Assign conferences and journals to communities, with ratings
- Query researchers active in a community based on their publications
- Import/Export: Load and save community definitions to/from file
- Analysis: Overlap of communities, track where researchers publish after leaving a community (BR-13)
- Filter and sort by ratings, research output (count and weighted)
- Automatic import of conference/journal ratings from external sources (BR-19, BR-20)
- Graphical evaluation and reporting of analysis results

---

# Slide 6 — Requirements

- High-Level Requirements: see CommunityAnalyzer Requirements document (BR-01 to BR-21, BR-11 absent)
- Programming Language: Java
- Technology
  - Backend: Java
  - Frontend: JavaFX (SceneBuilder)
  - Storage: File-based or PostgreSQL (team's choice)

---

# Slide 7 — Organization

- Working in teams of 3 students
- Tasks should be equally distributed considering the amount of effort
- Effort: 6 ECTS (~ 150 working hours) internship and group appointments included
- LVA-leader is your Client and Advisor
- Recommendation: Completion of VL/UE Software Engineering. Java programming fundamentals (SW1, SW2) are assumed.

> **Each team member must participate in the implementation of the application – Equally distributed implementation tasks!**

---

# Slide 8 — Time Schedule

- The Software Product is being developed in three releases
  - Release 1: 11 April 2026 (Saturday)
  - Release 2: 16 May 2026 (Saturday)
  - Release 3: 27 June 2026 (Saturday)
  - Final Submission: 13 July 2026 (Monday)
- Submission per Release: Branch in Git with all the Documentation + Code
- Each release must be tagged in Git (e.g., R1, R2, R3)

---

# Slide 9 — Appointments - Sprint Meetings

- 3 Release Review + Sprint Planning Meetings
  - **14.04.2026** — Release 1 Review + Sprint Planning 2
  - **19.05.2026** — Release 2 Review + Sprint Planning 3
  - **30.06.2026** — Final Sprint Planning + Final Presentation
  - Mandatory attendance of the entire team
  - 10 minutes presentation (Slide-Template)
  - Each member should participate in the presentation
  - Discussion, Status, Next Steps…
- 3 Project Meetings (individual teams)
  - **24.03.2026** — Project Meeting
  - **05.05.2026** — Project Meeting
  - **02.06.2026** — Project Meeting (Code Review)
  - Feedback & Questions (30 Minutes)

---

# Slide 10 — Agile Software Development

- Iterative development (Sprints)
  - 1 Week to max. 1 Month
- Prioritize a set of requirements, the Team decides which ones must be implemented in each sprint
- Result of a Sprint = New version of the product
- No dedicated roles in the team
  - Between 5 and 9 developers per Team
- High level of self-organization

---

# Slide 11 — Release 1

**Release 1: 11.04.2026 — Review: 14.04.2026**

**Goal: UI Prototype and OO Design**

**Deliverables:**

- First concept for building the application (which Features, Components,..)
- UML Class Diagram with the most important classes (Class names, Hierarchies, Methodology, Patterns…) with a UML Tool!
- Entity Relationship Diagram of the database structure (if PostgreSQL is chosen)
- UI Prototype (JavaFX / SceneBuilder)
- Continuous Integration with GitHub Actions
- Presentation of the Project Status 1 (for Sprint Planning Meeting)

---

# Slide 12 — Release 2

**Release 2: 16.05.2026 — Review: 19.05.2026**

**Goal: Prototype Implementation and Unit Tests**

**Deliverables:**

- Extended/updated UML Diagrams
- Prototype Implementation:
  - First version of the User Interface (JavaFX)
  - Some implemented functionality (e.g., DBLP import, CRUD communities)
- Unit Tests for individual (important) classes
- User Stories with Acceptance Criteria (linked to Software Requirements)
- Code Quality Report (The team should present at maximum 2 fixes proposed by SonarQube)
- Presentation of the Project Status 2 (for Sprint Planning Meeting)

---

# Slide 13 — Release 3

**Release 3: 27.06.2026 — Review: 30.06.2026**

**Goal: Documentation**

**Deliverables:**

- Extended/updated UML Diagrams
- Extended Unit Tests
- Implementation:
  - User Interfaces
  - Implemented most of the functionalities (all Features available)
- First version of the project documentation
- Final Code Quality Report (SonarQube — What is the quality of the final code?)
- Technical debt reduced based on SonarQube findings (mandatory from Release 2 onwards)
- Presentation of the Project Status 3 (for Sprint Planning Meeting)
- Code coverage equal or higher to 85% for all non-UI test code
- Live Demo/Screencast of the Application

---

# Slide 14 — Final Product

**Final Submission: 13.07.2026**

**Deliverables:**

- Final Project documentation
- Executable, final version of the application (on GitHub main branch, tagged)
- GitHub Documentation (README with Installation Instructions, etc.)
- Javadoc for important classes, Interfaces and Methods
- All User Stories closed with Definition of Done satisfied

---

# Slide 15 — Evaluation

The criteria for assessment as follows:

- Functionality of the product
- External Quality of the Product (Stability, Efficiency, User Interface)
- Internal Quality of the Product (OO Design, MVC separation, Programming Quality, API-Documentation, SonarQube technical debt)
- Unit Tests (≥ 85% branch coverage for non-UI code) and Quality of the Unit Tests
- Quality of the Documentation (Design, Test cases, Experience Report)
- Process Quality (GitHub Projects, Merge Requests per User Story, commit discipline, Definition of Done)
- Presentations

---

# Slide 16 — Tools for the Course

- Java 21, JavaFX 23.0.2
- GitHub Projects
- Git (GitHub)
- Maven
- GitHub Actions (CI/CD)
- UML Editor / UI Prototyping Tool
- SceneBuilder 23.0.1 (JavaFX UI design)
- Code Coverage Library: JaCoCo
- Code Quality: SonarQube (local Docker) + SonarLint (IDE plugin)
- PostgreSQL 16 + pgAdmin 4 (optional, for teams choosing database storage)

---

# Slide 17 — Project Organisation with GitHub Projects

- Implementation details (detailed specification) in GitHub Projects
  - For each release: Software Requirements, User Stories, Tasks, Bugs
  - Assign to each task a responsible and a cost in time! – The responsible must implement the source code (Code + Unit Tests)
- Create a Release Planning (Roadmap) in GitHub Projects
  - At the end of each release, the respective tasks, requirements, bugs, etc must be completed and closed.
- Merge Request per User Story is mandatory
- Tag each release in Git (e.g., R1, R2, R3)

---

# Slide 18 — Source Code Management with Git

- GitHub to manage Code and Documentation
  - Code must be committed in GitHub at least 1 per Week
  - Always enter the respective id for each commit (#IssueNr). – Each team member must write some code and make commits!
- Quality feedback via SonarQube / SonarLint – The source code must be kept clean
- Document known issues that are not yet fixed
- The submission for each release must be committed in a separate GitHub branch

---

# Slide 19 — Resources

**Documentation, Tutorials, Links….**
TBD — GitHub Wiki / Course Repository

**Data Sources**
- DBLP XML: https://dblp.uni-trier.de/xml
- GII-GRIN-SCIE Conference Rating: http://gii-grin-scie-rating.scie.es/

**Tool Documentation**
- SonarQube: https://docs.sonarsource.com/sonarqube-community-build/
- GitHub Actions: https://docs.github.com/en/actions
- JavaFX / SceneBuilder: https://openjfx.io/

**Questions**
Moodle Q&A Forum
Must conform to https://stackoverflow.com/help/how-to-ask

**Announcements**
Moodle News Forum

---

# Slide 20 — Next steps

**Now (10.03.2026):**
- Build teams of 3 Students - 1 "Team Leader" Email to luca.berardinelli@jku.at
  [Subject: PR_SE2026 Team] (Name, Matr.Nr, email, GitHub user)
- Distribution of topics for the Workshop

**For Next week (17.03.2026):**
- Get familiar with the requirements and prepare questions for the Workshop
- Plan the first version of the product and define the initial responsibilities for each member
- Get familiar with Git, Maven, GitHub Projects, SonarQube/SonarLint…

**By 21.03.2026:** Complete planning for Release 1 in GitHub Projects

---

# Slide 21 — SE Tools Workshop: 17.03.2026

- Topic-1: Git
- Topic-2: Maven + GitHub Actions
- Topic-3: UML Tools / Editors
- Topic-4: UI Prototyping with SceneBuilder
- Topic-5: SonarQube + Code Quality

---

# Slide 22 — Topic-1: Git

- Git Functions and Markdown
  - Create branch
  - Commit
  - Push
  - Minimal example of how to resolve conflicts
  - Create a Pull Request and merge
- Tools:
  - Git Bash, Git in VS Code, GitHub Desktop, SourceTree
- Tutorial: https://rogerdudler.github.io/git-guide/index.de.html

---

# Slide 23 — Topic-2: Maven + GitHub Actions

- What is Maven? How to add dependencies to the project?
- What is GitHub Actions?
- Create a Maven Project (e.g., sum calculator)
- Create at least one Unit Test (e.g., test the sum class)
- Add JaCoCo plugin to Maven and generate code coverage report
- Compile and Test with GitHub Actions
- Execute the jar

---

# Slide 24 — Topic-3: UML Tools / Editors

- Explore different UML Tools
- Suggested tools: PlantUML, diagrams.net (draw.io), Umlet, Mermaid (GitHub-native)
- The team should explore at least 4 tools and show minimal examples
- The group should show the functionalities (e.g., diagram creation, code generation, etc.) of the tools
- Small comparison of the tools

---

# Slide 25 — Topic-4: UI Prototyping with SceneBuilder

- What is JavaFX? What is SceneBuilder?
- SceneBuilder 23.0.1 is mandatory
- Suggested tools: Figma (free tier), Pencil Project (open-source), Penpot (open-source)
- The team should explore SceneBuilder and at least 3 other UI prototyping tools
- Create a minimal JavaFX UI prototype using SceneBuilder (FXML)
- The group should show the functionalities (e.g., layout design, event binding, code generation) of the tools
- Small comparison of the tools

---

# Slide 26 — Topic-5: SonarQube + Code Quality

- What is SonarQube? What is SonarLint?
  https://docs.sonarsource.com/sonarqube-community-build/
- What is the difference between SonarQube and SonarLint?
- How to set up SonarQube locally (Docker)?
- Run a first analysis on a Maven project with JaCoCo code coverage
- Show an example of a code smell detected and fixed
- Integrate SonarQube analysis into GitHub Actions pipeline
- Explain Quality Gate: what it is and what happens when it fails
