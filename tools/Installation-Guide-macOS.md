# SE-Praktikum 2026 — macOS Installation Guide

**Course:** Praktikum Software Engineering — SS 2026
**Platform:** macOS 13 (Ventura) or later
**Note:** This guide uses Homebrew where it simplifies installation.

---

## Table of Contents

1. [Homebrew (prerequisite)](#1-homebrew-prerequisite)
2. [Java JDK 21](#2-java-jdk-21)
3. [JavaFX 23.0.2](#3-javafx-2302)
4. [Apache Maven](#4-apache-maven)
5. [SceneBuilder 23.0.1](#5-scenebuilder-2301)
6. [Git](#6-git)
7. [GitHub Desktop](#7-github-desktop)
8. [SourceTree](#8-sourcetree)
9. [Visual Studio Code](#9-visual-studio-code)
10. [SonarQube Community Edition](#10-sonarqube-community-edition)
11. [SonarLint](#11-sonarlint)
12. [JaCoCo](#12-jacoco)
13. [PlantUML](#13-plantuml)
14. [diagrams.net (draw.io)](#14-diagramsnet-drawio)
15. [Umlet](#15-umlet)
16. [Figma](#16-figma)
17. [Pencil Project](#17-pencil-project)
18. [Penpot](#18-penpot)
19. [PostgreSQL 16](#19-postgresql-16)
20. [pgAdmin 4](#20-pgadmin-4)

---

## 1. Homebrew (prerequisite)

Homebrew is the standard package manager for macOS. It greatly simplifies installing and updating development tools.

### Installation

Open Terminal and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

On Apple Silicon (M1/M2/M3/M4) Macs, Homebrew installs to `/opt/homebrew`. The installer will print instructions to add it to your PATH. Follow them — typically:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Verify

```bash
brew --version
```

### Update

Before installing packages, always update Homebrew:

```bash
brew update
```

---

## 2. Java JDK 21

### Installation via Homebrew (recommended)

```bash
brew install --cask temurin@21
```

This installs Eclipse Temurin JDK 21 with proper macOS integration.

### Set JAVA_HOME

Add to your `~/.zshrc`:

```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"
```

Reload:

```bash
source ~/.zshrc
```

### Verify

```bash
java -version
javac -version
echo $JAVA_HOME
```

Expected output should show `openjdk version "21.x.x"`.

### Troubleshooting

If you have multiple JDKs installed, list them:

```bash
/usr/libexec/java_home -V
```

Ensure the `JAVA_HOME` export in `~/.zshrc` points to version 21.

---

## 3. JavaFX 23.0.2

### With Maven (recommended — no manual download)

Add dependencies to your `pom.xml`:

```xml
<dependency>
    <groupId>org.openjfx</groupId>
    <artifactId>javafx-controls</artifactId>
    <version>23.0.2</version>
</dependency>
<dependency>
    <groupId>org.openjfx</groupId>
    <artifactId>javafx-fxml</artifactId>
    <version>23.0.2</version>
</dependency>
```

Maven downloads the correct platform-specific binaries (including Apple Silicon) automatically.

### Manual Download (optional)

1. Go to https://openjfx.io/
2. Download **JavaFX SDK 23.0.2** for macOS (select your architecture: aarch64 for Apple Silicon, x64 for Intel)
3. Extract to `~/tools/javafx-sdk-23.0.2`
4. Add to `~/.zshrc`:

```bash
export PATH_TO_FX="$HOME/tools/javafx-sdk-23.0.2/lib"
```

### Verify

```bash
ls ~/tools/javafx-sdk-23.0.2/lib/*.jar
```

---

## 4. Apache Maven

### Installation via Homebrew

```bash
brew install maven
```

That's it. Homebrew handles PATH configuration automatically.

### Verify

```bash
mvn -version
```

Expected output shows Maven version and Java 21 as the runtime. If Maven picks up the wrong Java, check that `JAVA_HOME` is set correctly (see Step 2).

---

## 5. SceneBuilder 23.0.1

### Installation

1. Go to https://gluonhq.com/products/scene-builder/
2. Download the **macOS installer (DMG)** for version 23.0.1
3. Open the DMG and drag SceneBuilder to your Applications folder

### Integration with VS Code

1. Open VS Code
2. Install the extension **"SceneBuilder extension for Visual Studio Code"** (`bilalekrem.scenebuilderextension`)
3. In VS Code settings, set the SceneBuilder path:

```json
{
    "scenebuilder.path": "/Applications/SceneBuilder.app/Contents/MacOS/SceneBuilder"
}
```

4. Right-click any `.fxml` file → **Open in SceneBuilder**

### Verify

Launch SceneBuilder from Applications. You should see the visual editor with a component library on the left and a canvas in the center.

---

## 6. Git

### Installation via Homebrew

macOS ships with a Git version via Xcode Command Line Tools, but it is often outdated. Install the latest via Homebrew:

```bash
brew install git
```

### Initial Configuration

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@students.jku.at"
git config --global init.defaultBranch main
```

### Verify

```bash
git --version
which git
```

`which git` should show `/opt/homebrew/bin/git` (Homebrew version), not `/usr/bin/git` (Apple version).

### Troubleshooting

If `which git` still shows `/usr/bin/git`, ensure Homebrew's bin directory comes first in your PATH. Check `~/.zshrc`:

```bash
export PATH="/opt/homebrew/bin:$PATH"
```

---

## 7. GitHub Desktop

### Installation via Homebrew

```bash
brew install --cask github
```

### Manual Installation

1. Download from https://desktop.github.com/
2. Open the DMG and drag to Applications

### Setup

1. Launch GitHub Desktop
2. Sign in with your GitHub account
3. Configure your Git identity (should match Step 6)

### Verify

After signing in, you should see your GitHub repositories listed under "Your repositories".

---

## 8. SourceTree

### Installation via Homebrew

```bash
brew install --cask sourcetree
```

### Manual Installation

1. Download from https://www.sourcetreeapp.com/
2. Open the DMG and drag to Applications

### Setup

1. Launch SourceTree
2. Create or sign in with an Atlassian account (free)
3. When asked about Mercurial, skip it — only Git is needed

### Verify

Open SourceTree. You should be able to clone repositories and see a visual branch/commit history.

---

## 9. Visual Studio Code

### Installation via Homebrew

```bash
brew install --cask visual-studio-code
```

### Manual Installation

1. Download from https://code.visualstudio.com/
2. Open the ZIP/DMG and drag VS Code to Applications

### Add to PATH

After installation, open VS Code and press `Cmd+Shift+P`, type **"Shell Command: Install 'code' command in PATH"** and select it. This lets you open VS Code from Terminal with `code .`.

### Essential Extensions

Install all course extensions at once from Terminal:

```bash
code --install-extension vscjava.vscode-java-pack
code --install-extension SonarSource.sonarlint-vscode
code --install-extension jebbs.plantuml
code --install-extension hediet.vscode-drawio
code --install-extension bilalekrem.scenebuilderextension
code --install-extension eamodio.gitlens
code --install-extension bierner.markdown-mermaid
```

| Extension | ID | Purpose |
|---|---|---|
| Extension Pack for Java | `vscjava.vscode-java-pack` | Java language support, debugging, testing, Maven |
| SonarLint | `SonarSource.sonarlint-vscode` | Real-time code quality feedback |
| PlantUML | `jebbs.plantuml` | UML diagram preview |
| Draw.io Integration | `hediet.vscode-drawio` | Edit diagrams inside VS Code |
| SceneBuilder | `bilalekrem.scenebuilderextension` | Open FXML files in SceneBuilder |
| GitLens | `eamodio.gitlens` | Enhanced Git integration |
| Mermaid Preview | `bierner.markdown-mermaid` | Preview Mermaid diagrams in Markdown |

### Verify

Open VS Code, create a `.java` file. You should see syntax highlighting, IntelliSense, and a "Run" button above the main method.

---

## 10. SonarQube Community Edition

### Download

Go to https://www.sonarsource.com/open-source-editions/sonarqube-community-edition/ and download the **ZIP distribution**.

### Prerequisites

SonarQube 10.x requires Java 17 (not 21). Install a separate JDK 17:

```bash
brew install --cask temurin@17
```

Note the install path:

```bash
/usr/libexec/java_home -v 17
```

### Installation

1. Extract the ZIP:

```bash
mkdir -p ~/tools
unzip sonarqube-10.*.zip -d ~/tools/
```

2. Configure SonarQube to use Java 17. Edit `~/tools/sonarqube-10.x/conf/wrapper.conf` and add:

```
wrapper.java.command=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin/java
```

Replace the path with the actual output of `/usr/libexec/java_home -v 17`.

### Start SonarQube

```bash
cd ~/tools/sonarqube-10.x/bin/macosx-universal-64
./sonar.sh start
```

Wait 1–2 minutes for startup. Check status:

```bash
./sonar.sh status
```

### First Access

1. Open http://localhost:9000 in your browser
2. Login with `admin` / `admin`
3. You will be prompted to change the password

### Create a Project Token

1. Go to **Administration → Security → Users → Tokens**
2. Generate a token — save it, you will need it for Maven integration

### Verify

http://localhost:9000 shows the SonarQube dashboard.

### Stop SonarQube

```bash
cd ~/tools/sonarqube-10.x/bin/macosx-universal-64
./sonar.sh stop
```

---

## 11. SonarLint

SonarLint is a VS Code extension — no separate installation needed.

### Installation

Already installed in Step 9 via:

```bash
code --install-extension SonarSource.sonarlint-vscode
```

### Connect to SonarQube (optional)

In VS Code settings (`Cmd+,`), search for "SonarLint: Connected Mode" and add:

```json
{
    "sonarlint.connectedMode.connections.sonarqube": [
        {
            "serverUrl": "http://localhost:9000",
            "token": "<your-token-from-step-10>"
        }
    ]
}
```

### Verify

Open a Java file with a known issue (e.g., unused variable). SonarLint should underline it with a yellow squiggly and show a description in the "Problems" panel.

---

## 12. JaCoCo

JaCoCo is a Maven plugin — no separate installation needed.

### Configuration

Add JaCoCo to your `pom.xml`:

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.jacoco</groupId>
            <artifactId>jacoco-maven-plugin</artifactId>
            <version>0.8.12</version>
            <executions>
                <execution>
                    <goals>
                        <goal>prepare-agent</goal>
                    </goals>
                </execution>
                <execution>
                    <id>report</id>
                    <phase>test</phase>
                    <goals>
                        <goal>report</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

### Generate Report

```bash
mvn clean test
```

### View Report

```bash
open target/site/jacoco/index.html
```

The report shows line, branch, and method coverage for each class.

---

## 13. PlantUML

### Installation via Homebrew

```bash
brew install plantuml
```

This installs PlantUML **and** Graphviz (required dependency) in one step.

### VS Code Integration

Already installed in Step 9 via:

```bash
code --install-extension jebbs.plantuml
```

Create a `.puml` file and press `Option+D` to preview.

### Verify

```bash
plantuml -version
```

Or create a file `test.puml`:

```
@startuml
class Community {
  - name: String
  - description: String
}
@enduml
```

Generate:

```bash
plantuml test.puml
open test.png
```

---

## 14. diagrams.net (draw.io)

### Option A: Browser (no installation)

Go to https://app.diagrams.net/ — works immediately.

### Option B: Desktop Application via Homebrew

```bash
brew install --cask drawio
```

Or download manually from https://github.com/jgraph/drawio-desktop/releases.

### Option C: VS Code Extension

Already installed in Step 9. Create a file with `.drawio` extension — VS Code opens the full editor inline.

### Verify

Create a new diagram, add a UML class element, save as `.drawio` file.

---

## 15. Umlet

### Download

Go to https://www.umlet.com/changes.htm and download the **standalone version** (ZIP).

### Installation

```bash
mkdir -p ~/tools
unzip Umlet-*.zip -d ~/tools/
```

Run:

```bash
cd ~/tools/Umlet
java -jar umlet.jar
```

### Online Alternative

Use https://www.umletino.com/ in a browser — no installation required.

### Verify

Launch Umlet. Create a new class diagram by typing in the text panel on the right.

---

## 16. Figma

Figma is browser-based — no installation required.

### Setup

1. Go to https://www.figma.com/
2. Create a free account (sign up with your JKU email)
3. The free plan supports up to 3 projects with unlimited collaborators

### Desktop App (optional)

```bash
brew install --cask figma
```

Or download from https://www.figma.com/downloads/.

### Verify

Create a new design file, add a frame (F), and draw a rectangle (R).

---

## 17. Pencil Project

### Download

Go to https://pencil.evolus.vn/ and download the **macOS installer (DMG)**.

### Installation

Open the DMG and drag Pencil to Applications.

### Verify

Launch Pencil from Applications. You should see a canvas with a shapes panel on the left.

---

## 18. Penpot

Penpot is browser-based — no installation required.

### Setup

1. Go to https://penpot.app/
2. Click **"Start designing"**
3. Create a free account

### Verify

Create a new project, open a new page, and add shapes.

---

## 19. PostgreSQL 16

**Only required if your team chooses database storage.**

### Installation via Homebrew

```bash
brew install postgresql@16
```

### Start the Service

```bash
brew services start postgresql@16
```

This runs PostgreSQL as a background service that starts automatically on login.

### Add to PATH

Homebrew may print a caveat about adding PostgreSQL to PATH. Add to `~/.zshrc`:

```bash
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
```

Reload:

```bash
source ~/.zshrc
```

### Create a Database for the Project

```bash
createdb communityanalyzer
psql communityanalyzer
```

```sql
CREATE USER causer WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE communityanalyzer TO causer;
\q
```

### Verify

```bash
psql --version
psql communityanalyzer -c "SELECT version();"
```

You should see `PostgreSQL 16.x`.

### Stop the Service

```bash
brew services stop postgresql@16
```

---

## 20. pgAdmin 4

**Only required if your team chooses database storage.**

### Installation via Homebrew

```bash
brew install --cask pgadmin4
```

### Manual Installation

Download from https://www.pgadmin.org/download/pgadmin-4-macos/.

### Setup

1. Launch pgAdmin 4 from Applications
2. Set a **master password** for pgAdmin (separate from PostgreSQL password)
3. Right-click "Servers" → "Register" → "Server"
4. **General tab:** Name = `Local PostgreSQL`
5. **Connection tab:**
   - Host: `localhost`
   - Port: `5432`
   - Username: your macOS username (Homebrew PostgreSQL uses your system user by default)
   - Password: leave empty if using default Homebrew setup (peer authentication)
6. Click "Save"

### Verify

Expand the server in the left panel. You should see your `communityanalyzer` database listed under Databases.

---

## Quick Verification Checklist

Run this in Terminal to verify all command-line tools:

```bash
echo "=== Homebrew ==="
brew --version

echo -e "\n=== Java ==="
java -version

echo -e "\n=== Maven ==="
mvn -version

echo -e "\n=== Git ==="
git --version
which git

echo -e "\n=== VS Code ==="
code --version

echo -e "\n=== PlantUML ==="
plantuml -version 2>/dev/null || echo "Not installed"

echo -e "\n=== PostgreSQL (optional) ==="
psql --version 2>/dev/null || echo "Not installed (optional)"
```

---

## Homebrew Summary

Tools installed via `brew install` (CLI):

```bash
brew install git
brew install maven
brew install plantuml
brew install postgresql@16
```

Tools installed via `brew install --cask` (GUI apps):

```bash
brew install --cask temurin@21
brew install --cask temurin@17          # for SonarQube only
brew install --cask visual-studio-code
brew install --cask github              # GitHub Desktop
brew install --cask sourcetree
brew install --cask drawio
brew install --cask figma
brew install --cask pgadmin4
```

One-liner to install everything:

```bash
brew install git maven plantuml postgresql@16 && \
brew install --cask temurin@21 temurin@17 visual-studio-code github sourcetree drawio figma pgadmin4
```

---

## Environment Variables Summary (~/.zshrc)

```bash
# Java 21 (primary)
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"

# PostgreSQL 16 (optional)
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# JavaFX (only if not using Maven)
# export PATH_TO_FX="$HOME/tools/javafx-sdk-23.0.2/lib"
```

After editing `~/.zshrc`, reload with:

```bash
source ~/.zshrc
```

---

## Tools Not Requiring Installation

| Tool | Access |
|------|--------|
| GitHub Projects | https://github.com (browser) |
| GitHub Actions | Configured via `.github/workflows/` in your repo |
| Mermaid | Native rendering in GitHub Markdown |
| Figma | https://www.figma.com/ (browser) |
| Penpot | https://penpot.app/ (browser) |
| diagrams.net | https://app.diagrams.net/ (browser) |
| Umletino | https://www.umletino.com/ (browser) |
| JaCoCo | Maven plugin (no separate install) |
| SonarLint | VS Code extension |
