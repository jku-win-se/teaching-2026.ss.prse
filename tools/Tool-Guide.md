# SE-Praktikum 2026 — Tool Guide

**Course:** Praktikum Software Engineering — SS 2026
**Purpose:** Overview of all tools used in the course, grouped by role.

---

## 1. Language & Runtime

### Java JDK 21

Java is the programming language for this course. JDK 21 is a Long-Term Support (LTS) release, providing the latest stable language features including virtual threads, pattern matching, and record patterns. All backend logic, data processing, and application code will be written in Java.

| | |
|---|---|
| **Version** | 21 (LTS) |
| **Download** | https://jdk.java.net/21/ |
| **Alternative** | https://adoptium.net/temurin/releases/?version=21 (Eclipse Temurin) |

### JavaFX 23.0.2

JavaFX is the UI framework for building the desktop application. It provides a modern widget toolkit with CSS styling, FXML declarative layouts, and hardware-accelerated graphics. JavaFX is distributed separately from the JDK since Java 11.

| | |
|---|---|
| **Version** | 23.0.2 |
| **Download** | https://openjfx.io/ |
| **Maven** | Add `org.openjfx` dependencies to `pom.xml` |

---

## 2. Build & Dependencies

### Apache Maven

Maven is the build automation and dependency management tool for the project. It compiles code, runs tests, packages JARs, and manages library dependencies through a central `pom.xml` file. Maven is also the integration point for JaCoCo (coverage) and SonarQube (quality analysis).

| | |
|---|---|
| **Version** | Latest stable |
| **Download** | https://maven.apache.org/download.cgi |
| **Documentation** | https://maven.apache.org/guides/ |

---

## 3. UI Design

### SceneBuilder 23.0.1

SceneBuilder is the visual layout editor for JavaFX. It generates FXML files through a drag-and-drop interface, allowing you to design UIs without writing layout code manually. SceneBuilder is **mandatory** for this course — all teams must use it for their JavaFX interface design.

| | |
|---|---|
| **Version** | 23.0.1 |
| **Download** | https://gluonhq.com/products/scene-builder/ |
| **Documentation** | https://openjfx.io/openjfx-docs/#scene-builder |

### Figma

Figma is a collaborative, browser-based UI design tool widely used in industry. It allows teams to create high-fidelity mockups, interactive prototypes, and design systems. The free tier supports up to 3 projects with unlimited collaborators, making it ideal for student teams.

| | |
|---|---|
| **Version** | Free tier |
| **Link** | https://www.figma.com/ |
| **Documentation** | https://help.figma.com/ |

### Pencil Project

Pencil Project is an open-source, desktop-based GUI prototyping tool. It provides built-in shape collections for common UI elements (buttons, forms, dialogs) and supports exporting to PNG, SVG, and PDF. Lightweight and simple — no account required.

| | |
|---|---|
| **Version** | Latest |
| **Download** | https://pencil.evolus.vn/ |
| **Source** | https://github.com/nickthecook/pencil |

### Penpot

Penpot is an open-source design and prototyping platform, similar to Figma but fully free and self-hostable. It runs in the browser, supports real-time collaboration, and uses open standards (SVG). A good choice for teams who prefer open-source tools.

| | |
|---|---|
| **Version** | Latest |
| **Link** | https://penpot.app/ |
| **Source** | https://github.com/penpot/penpot |

---

## 4. Version Control

### Git

Git is the distributed version control system used to manage all source code and documentation. Every team member must commit regularly (at least once per week), use meaningful commit messages with issue references (#IssueNr), and work with branches for each release.

| | |
|---|---|
| **Version** | Latest |
| **Download** | https://git-scm.com/downloads |
| **Tutorial** | https://rogerdudler.github.io/git-guide/index.de.html |

### GitHub Desktop

GitHub Desktop is a graphical Git client that simplifies common operations like commits, branches, pull requests, and merge conflict resolution. Recommended for students who prefer a visual interface over the command line.

| | |
|---|---|
| **Version** | Latest |
| **Download** | https://desktop.github.com/ |

### SourceTree

SourceTree is a free Git GUI client by Atlassian. It provides a detailed visual representation of branches, commits, and history. Supports both Git and Mercurial. A good alternative to GitHub Desktop for students who want more advanced repository visualization.

| | |
|---|---|
| **Version** | Latest |
| **Download** | https://www.sourcetreeapp.com/ |

---

## 5. Project Management

### GitHub Projects

GitHub Projects is the integrated project management tool within GitHub. It provides Kanban-style boards, roadmaps, and custom fields to track Software Requirements, User Stories, Tasks, and Bugs. In this course, GitHub Projects is used for sprint planning, release tracking, and responsibility assignment.

| | |
|---|---|
| **Link** | https://github.com (integrated in every repository) |
| **Documentation** | https://docs.github.com/en/issues/planning-and-tracking-with-projects |

---

## 6. CI/CD

### GitHub Actions

GitHub Actions is the CI/CD platform built into GitHub. It automates the build-test-analyze pipeline: on every push, it compiles the Maven project, runs JUnit tests, generates JaCoCo coverage reports, and sends results to SonarQube. Workflows are defined in YAML files under `.github/workflows/`.

| | |
|---|---|
| **Link** | https://github.com/features/actions |
| **Documentation** | https://docs.github.com/en/actions |
| **Quickstart** | https://docs.github.com/en/actions/quickstart |

---

## 7. Code Quality

### SonarQube Community Edition

SonarQube is a static code analysis platform that detects bugs, code smells, security vulnerabilities, and tracks technical debt over time. It runs as a local Docker container and receives analysis results from the Maven build via GitHub Actions. The Quality Gate mechanism decides whether a release meets the minimum quality threshold.

| | |
|---|---|
| **Version** | Community Edition (latest) |
| **Download** | https://www.sonarsource.com/open-source-editions/sonarqube-community-edition/ |
| **Documentation** | https://docs.sonarsource.com/sonarqube-community-build/ |
| **Setup** | Docker: `docker pull sonarqube:community` |

### SonarLint

SonarLint is an IDE plugin that provides real-time code quality feedback as you write code. It detects the same issues as SonarQube but directly in your editor, before you even commit. Available for VS Code, IntelliJ IDEA, and Eclipse. When connected to a SonarQube server, it synchronizes rules and quality profiles.

| | |
|---|---|
| **Version** | Latest |
| **Download** | https://www.sonarsource.com/products/sonarlint/ |
| **VS Code** | https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode |
| **IntelliJ** | https://plugins.jetbrains.com/plugin/7973-sonarlint |

---

## 8. Code Coverage

### JaCoCo

JaCoCo (Java Code Coverage) is the library that measures how much of your code is actually executed by your unit tests. It integrates as a Maven plugin, instruments your classes during test execution, and produces detailed reports showing line, branch, and method coverage. SonarQube reads JaCoCo reports to display coverage metrics and enforce Quality Gate thresholds. The course requires ≥ 85% branch coverage for non-UI code.

| | |
|---|---|
| **Version** | Latest |
| **Link** | https://www.jacoco.org/jacoco/ |
| **Maven Plugin** | https://www.jacoco.org/jacoco/trunk/doc/maven.html |
| **Documentation** | https://www.jacoco.org/jacoco/trunk/doc/ |

---

## 9. UML & Diagrams

### PlantUML

PlantUML generates UML diagrams from plain text descriptions. Diagrams are defined in a simple markup language and rendered as PNG, SVG, or ASCII art. Because diagrams are text files, they can be versioned in Git and diffed like code. A VS Code extension provides live preview.

| | |
|---|---|
| **Version** | Latest |
| **Link** | https://plantuml.com/ |
| **Download** | https://plantuml.com/download |
| **VS Code Extension** | https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml |

### diagrams.net (draw.io)

diagrams.net (formerly draw.io) is a free, browser-based diagramming tool. It supports UML, flowcharts, ER diagrams, and many other diagram types through drag-and-drop. Diagrams can be saved as XML files in your Git repository and exported as SVG or PNG. No account required.

| | |
|---|---|
| **Link** | https://app.diagrams.net/ |
| **Desktop** | https://github.com/jgraph/drawio-desktop/releases |
| **VS Code Extension** | https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio |

### Umlet

Umlet is a lightweight, Java-based UML tool with a minimalist interface. Diagrams are created by typing text into elements rather than filling dialog boxes, making it fast for quick sketches. It runs as a standalone application or as an Eclipse plugin.

| | |
|---|---|
| **Version** | Latest |
| **Link** | https://www.umlet.com/ |
| **Download** | https://www.umlet.com/changes.htm |
| **Online** | https://www.umletino.com/ |

### Mermaid

Mermaid renders diagrams from Markdown-like text definitions. Its key advantage is native support in GitHub — diagrams defined in Mermaid syntax inside Markdown files are automatically rendered in GitHub READMEs, issues, and wikis. Supports class diagrams, sequence diagrams, flowcharts, ER diagrams, and Gantt charts.

| | |
|---|---|
| **Link** | https://mermaid.js.org/ |
| **Live Editor** | https://mermaid.live/ |
| **GitHub Docs** | https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams |

---

## 10. Database (optional)

### PostgreSQL 16

PostgreSQL is a powerful, open-source relational database. Teams that choose database storage (instead of file-based) will use PostgreSQL to persist communities, venues, researchers, and publications. Version 16 provides improved performance, logical replication, and enhanced JSON support.

| | |
|---|---|
| **Version** | 16 |
| **Download** | https://www.postgresql.org/download/ |
| **Docker** | `docker pull postgres:16-alpine` |
| **Documentation** | https://www.postgresql.org/docs/16/ |

### pgAdmin 4

pgAdmin is the standard graphical administration tool for PostgreSQL. It provides a web-based interface to browse databases, run SQL queries, inspect table structures, and manage users. Runs as a Docker container alongside PostgreSQL.

| | |
|---|---|
| **Version** | Latest |
| **Download** | https://www.pgadmin.org/download/ |
| **Docker** | `docker pull dpage/pgadmin4` |
| **Documentation** | https://www.pgadmin.org/docs/ |

---

## 11. IDE

### Visual Studio Code

VS Code is a lightweight, extensible code editor with excellent Java support through the Extension Pack for Java. It integrates with Git, Maven, SonarLint, PlantUML, draw.io, and GitHub — making it a single workspace for all course activities. Free and cross-platform.

| | |
|---|---|
| **Version** | Latest |
| **Download** | https://code.visualstudio.com/ |
| **Java Extension Pack** | https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack |
| **SceneBuilder Integration** | https://marketplace.visualstudio.com/items?itemName=bilalekrem.scenebuilderextension |

---

## Summary by Role

| Role | Tools |
|------|-------|
| Language & Runtime | Java 21, JavaFX 23.0.2 |
| Build & Dependencies | Maven |
| UI Design | SceneBuilder, Figma, Pencil Project, Penpot |
| Version Control | Git, GitHub Desktop, SourceTree |
| Project Management | GitHub Projects |
| CI/CD | GitHub Actions |
| Code Quality | SonarQube, SonarLint |
| Code Coverage | JaCoCo |
| UML & Diagrams | PlantUML, diagrams.net, Umlet, Mermaid |
| Database (optional) | PostgreSQL 16, pgAdmin 4 |
| IDE | VS Code |
