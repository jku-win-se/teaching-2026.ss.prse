# SE-Praktikum 2026 — Windows Installation Guide

**Course:** Praktikum Software Engineering — SS 2026
**Platform:** Windows 10 / 11
**Note:** This guide covers native Windows installation only (no Docker).

---

## Table of Contents

1. [Java JDK 21](#1-java-jdk-21)
2. [JavaFX 23.0.2](#2-javafx-2302)
3. [Apache Maven](#3-apache-maven)
4. [SceneBuilder 23.0.1](#4-scenebuilder-2301)
5. [Git](#5-git)
6. [GitHub Desktop](#6-github-desktop)
7. [SourceTree](#7-sourcetree)
8. [Visual Studio Code](#8-visual-studio-code)
9. [SonarQube Community Edition](#9-sonarqube-community-edition)
10. [SonarLint](#10-sonarlint)
11. [JaCoCo](#11-jacoco)
12. [PlantUML](#12-plantuml)
13. [diagrams.net (draw.io)](#13-diagramsnet-drawio)
14. [Umlet](#14-umlet)
15. [Figma](#15-figma)
16. [Pencil Project](#16-pencil-project)
17. [Penpot](#17-penpot)
18. [PostgreSQL 16](#18-postgresql-16)
19. [pgAdmin 4](#19-pgadmin-4)

---

## 1. Java JDK 21

### Download

Go to https://adoptium.net/temurin/releases/?version=21 and download the **Windows x64 MSI installer** (Eclipse Temurin JDK 21).

Alternatively, use the Oracle JDK from https://jdk.java.net/21/ (ZIP archive).

### Installation

1. Run the MSI installer
2. During installation, check **"Set JAVA_HOME variable"** and **"Add to PATH"**
3. Click through and finish

### Verify

Open a new PowerShell window and run:

```powershell
java -version
javac -version
echo $env:JAVA_HOME
```

Expected output should show `openjdk version "21.x.x"` and a valid JAVA_HOME path.

### Troubleshooting

If `java -version` shows an older version, another JDK may be on your PATH. Check with:

```powershell
where.exe java
```

Remove old Java entries from `System → Environment Variables → Path` or reorder them so JDK 21 comes first.

---

## 2. JavaFX 23.0.2

### Download

Go to https://openjfx.io/ and download the **JavaFX SDK 23.0.2** for Windows.

### Installation

1. Extract the ZIP to a permanent location, e.g. `C:\tools\javafx-sdk-23.0.2`
2. Set an environment variable for convenience:

```powershell
[System.Environment]::SetEnvironmentVariable("PATH_TO_FX", "C:\tools\javafx-sdk-23.0.2\lib", "User")
```

### Usage with Maven

If using Maven (recommended), you do **not** need to manually download JavaFX. Add dependencies to your `pom.xml`:

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

Maven will download the correct platform-specific binaries automatically.

### Verify

If installed manually, verify the SDK contents:

```powershell
dir "C:\tools\javafx-sdk-23.0.2\lib\*.jar"
```

You should see `javafx.base.jar`, `javafx.controls.jar`, `javafx.fxml.jar`, etc.

---

## 3. Apache Maven

### Download

Go to https://maven.apache.org/download.cgi and download the **Binary zip archive** (`apache-maven-3.x.x-bin.zip`).

### Installation

1. Extract the ZIP to `C:\tools\apache-maven-3.x.x`
2. Add Maven to your system PATH:

```powershell
# Add M2_HOME
[System.Environment]::SetEnvironmentVariable("M2_HOME", "C:\tools\apache-maven-3.9.9", "User")

# Add to PATH
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("Path", "$currentPath;C:\tools\apache-maven-3.9.9\bin", "User")
```

3. Close and reopen PowerShell

### Verify

```powershell
mvn -version
```

Expected output should show Maven version and the Java version it is using (should be JDK 21).

### Troubleshooting

If Maven uses the wrong Java version, ensure `JAVA_HOME` points to your JDK 21 installation. Maven reads `JAVA_HOME` to determine which JDK to use.

---

## 4. SceneBuilder 23.0.1

### Download

Go to https://gluonhq.com/products/scene-builder/ and download the **Windows Installer (MSI)** for version 23.0.1.

### Installation

1. Run the MSI installer
2. Follow the wizard — default settings are fine
3. SceneBuilder installs to `C:\Users\<you>\AppData\Local\SceneBuilder`

### Integration with VS Code

1. Open VS Code
2. Install the extension **"SceneBuilder extension for Visual Studio Code"** (ASharpPen.sbuilder)
3. In VS Code settings, set the SceneBuilder executable path:

```json
{
    "scenebuilder.path": "C:\\Users\\<you>\\AppData\\Local\\SceneBuilder\\SceneBuilder.exe"
}
```

4. Right-click any `.fxml` file → **Open in SceneBuilder**

### Verify

Launch SceneBuilder from the Start Menu. You should see the visual editor with a component library on the left and a canvas in the center.

---

## 5. Git

### Download

Go to https://git-scm.com/downloads and download **Git for Windows**.

### Installation

1. Run the installer
2. Recommended settings during installation:
   - **Default editor:** Select "Use Visual Studio Code as Git's default editor"
   - **PATH environment:** Select "Git from the command line and also from 3rd-party software"
   - **Line ending:** Select "Checkout as-is, commit Unix-style line endings"
   - **Terminal emulator:** Select "Use Windows' default console window"
   - **Default branch name:** Select "Override the default branch name" → type `main`
3. Finish installation

### Initial Configuration

Open PowerShell and configure your identity:

```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@students.jku.at"
git config --global init.defaultBranch main
```

### Verify

```powershell
git --version
git config --list
```

---

## 6. GitHub Desktop

### Download

Go to https://desktop.github.com/ and download the Windows installer.

### Installation

1. Run `GitHubDesktopSetup.exe`
2. Sign in with your GitHub account
3. Configure your Git identity (name and email — should match Step 5)

### Usage

- **Clone a repository:** File → Clone repository → select your course repo
- **Create a branch:** Branch → New Branch
- **Commit:** Write a message in the bottom-left, click "Commit to main"
- **Push:** Click "Push origin" in the top bar
- **Pull Request:** Branch → Create Pull Request → opens GitHub in browser

### Verify

After signing in, you should see your GitHub repositories listed under "Your repositories".

---

## 7. SourceTree

### Download

Go to https://www.sourcetreeapp.com/ and download the Windows installer.

### Installation

1. Run the installer
2. You will be asked to create or sign in with an Atlassian account (free)
3. When asked about "Mercurial", you can skip it — only Git is needed
4. Configure your Git identity

### Verify

Open SourceTree. You should be able to clone repositories and see a visual branch/commit history.

---

## 8. Visual Studio Code

### Download

Go to https://code.visualstudio.com/ and download the **Windows installer (User Setup, x64)**.

### Installation

1. Run the installer
2. During installation, check:
   - **"Add to PATH"** (important!)
   - **"Register Code as an editor for supported file types"**
   - **"Add 'Open with Code' action to file/directory context menu"**
3. Finish installation

### Essential Extensions

Open VS Code and install these extensions (Ctrl+Shift+X):

| Extension | ID | Purpose |
|---|---|---|
| Extension Pack for Java | `vscjava.vscode-java-pack` | Java language support, debugging, testing, Maven |
| SonarLint | `SonarSource.sonarlint-vscode` | Real-time code quality feedback |
| PlantUML | `jebbs.plantuml` | UML diagram preview |
| Draw.io Integration | `hediet.vscode-drawio` | Edit diagrams inside VS Code |
| SceneBuilder | `bilalekrem.scenebuilderextension` | Open FXML files in SceneBuilder |
| GitLens | `eamodio.gitlens` | Enhanced Git integration |
| Mermaid Preview | `bierner.markdown-mermaid` | Preview Mermaid diagrams in Markdown |

Install all at once from PowerShell:

```powershell
code --install-extension vscjava.vscode-java-pack
code --install-extension SonarSource.sonarlint-vscode
code --install-extension jebbs.plantuml
code --install-extension hediet.vscode-drawio
code --install-extension bilalekrem.scenebuilderextension
code --install-extension eamodio.gitlens
code --install-extension bierner.markdown-mermaid
```

### Verify

Open VS Code, create a `.java` file. You should see syntax highlighting, IntelliSense, and a "Run" button above the main method.

---

## 9. SonarQube Community Edition

### Download

Go to https://www.sonarsource.com/open-source-editions/sonarqube-community-edition/ and download the **ZIP distribution**.

### Prerequisites

- Java 17 (SonarQube 10.x requires Java 17, not 21). Download a separate JDK 17 from https://adoptium.net/temurin/releases/?version=17 and extract it to `C:\tools\jdk-17`.

### Installation

1. Extract the ZIP to `C:\tools\sonarqube-10.x`
2. Edit `C:\tools\sonarqube-10.x\conf\sonar.properties` if you need to change the port (default: 9000)
3. Set the Java 17 path for SonarQube:

Edit `C:\tools\sonarqube-10.x\conf\wrapper.conf` and add:

```
wrapper.java.command=C:/tools/jdk-17/bin/java
```

### Start SonarQube

```powershell
cd C:\tools\sonarqube-10.x\bin\windows-x86-64
.\StartSonar.bat
```

Wait 1–2 minutes for startup.

### First Access

1. Open http://localhost:9000 in your browser
2. Login with `admin` / `admin`
3. You will be prompted to change the password

### Create a Project Token

1. Go to **Administration → Security → Users → Tokens**
2. Generate a token — save it, you will need it for Maven integration

### Verify

http://localhost:9000 shows the SonarQube dashboard with "Passed" Quality Gate status.

### Stop SonarQube

Press `Ctrl+C` in the terminal where `StartSonar.bat` is running, or run:

```powershell
cd C:\tools\sonarqube-10.x\bin\windows-x86-64
.\StopNTService.bat
```

---

## 10. SonarLint

SonarLint is a VS Code extension — no separate installation needed.

### Installation

1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for **"SonarLint"** and install the one by **SonarSource**
4. Alternatively: https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode

### Connect to SonarQube (optional)

1. In VS Code, open settings (Ctrl+,)
2. Search for "SonarLint: Connected Mode"
3. Add a connection to your local SonarQube:

```json
{
    "sonarlint.connectedMode.connections.sonarqube": [
        {
            "serverUrl": "http://localhost:9000",
            "token": "<your-token-from-step-9>"
        }
    ]
}
```

### Verify

Open a Java file with a known issue (e.g., unused variable). SonarLint should underline it with a yellow squiggly and show a description in the "Problems" panel.

---

## 11. JaCoCo

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

```powershell
mvn clean test
```

### View Report

Open `target/site/jacoco/index.html` in your browser. The report shows line, branch, and method coverage for each class.

### Verify

After running `mvn clean test`, check that `target/jacoco.exec` exists and the HTML report is generated.

---

## 12. PlantUML

### Option A: VS Code Extension (recommended)

1. Install the **PlantUML** extension in VS Code (`jebbs.plantuml`)
2. Install **Graphviz** (required for rendering):
   - Download from https://graphviz.org/download/ (Windows stable release, MSI)
   - Run the installer, check **"Add to PATH"**
3. Create a `.puml` file and press `Alt+D` to preview

### Option B: Standalone JAR

1. Download `plantuml.jar` from https://plantuml.com/download
2. Place it in `C:\tools\plantuml\`
3. Run diagrams:

```powershell
java -jar C:\tools\plantuml\plantuml.jar diagram.puml
```

### Verify

Create a file `test.puml`:

```
@startuml
class Community {
  - name: String
  - description: String
}
@enduml
```

In VS Code, press `Alt+D` — you should see a rendered class diagram.

---

## 13. diagrams.net (draw.io)

### Option A: Browser (no installation)

Go to https://app.diagrams.net/ — works immediately. Save diagrams as `.drawio` XML files in your Git repository.

### Option B: Desktop Application

1. Download from https://github.com/jgraph/drawio-desktop/releases
2. Run the installer
3. Launch from Start Menu

### Option C: VS Code Extension

1. Install **"Draw.io Integration"** (`hediet.vscode-drawio`) in VS Code
2. Create a file with `.drawio` extension
3. VS Code opens the full draw.io editor inline

### Verify

Create a new diagram, add a UML class element, save as `.drawio` file.

---

## 14. Umlet

### Download

Go to https://www.umlet.com/changes.htm and download the **standalone version** (ZIP) for Windows.

### Installation

1. Extract the ZIP to `C:\tools\umlet`
2. Run `Umlet.exe`

No installation wizard needed — it runs directly from the extracted folder.

### Online Alternative

Use https://www.umletino.com/ in a browser — no installation required.

### Verify

Launch Umlet, create a new class diagram by typing in the text panel on the right. The diagram renders live on the left.

---

## 15. Figma

Figma is browser-based — no installation required.

### Setup

1. Go to https://www.figma.com/
2. Create a free account (sign up with your JKU email)
3. The free plan supports up to 3 projects with unlimited collaborators

### Desktop App (optional)

1. Download from https://www.figma.com/downloads/
2. Run the installer

The desktop app is a wrapper around the web version with better performance and system integration.

### Verify

Create a new design file, add a frame (F), and draw a rectangle (R). You should be able to design UI mockups with drag-and-drop.

---

## 16. Pencil Project

### Download

Go to https://pencil.evolus.vn/ and download the **Windows installer**.

### Installation

1. Run the installer
2. Follow the wizard — default settings are fine

### Verify

Launch Pencil Project from Start Menu. You should see a canvas with a shapes panel on the left containing UI elements (buttons, text fields, checkboxes, etc.).

---

## 17. Penpot

Penpot is browser-based — no installation required.

### Setup

1. Go to https://penpot.app/
2. Click **"Start designing"**
3. Create a free account

### Verify

Create a new project, open a new page, and add shapes. The interface is similar to Figma but fully open-source.

---

## 18. PostgreSQL 16

**Only required if your team chooses database storage.**

### Download

Go to https://www.postgresql.org/download/windows/ and download the **Windows installer** from EDB (EnterpriseDB).

### Installation

1. Run the installer
2. Set a **superuser password** for the `postgres` user — remember it!
3. Default port: **5432** (keep the default)
4. Leave locale as default
5. Uncheck "Launch Stack Builder" at the end (not needed)

### Add to PATH

The installer may not add PostgreSQL to PATH. Add manually:

```powershell
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("Path", "$currentPath;C:\Program Files\PostgreSQL\16\bin", "User")
```

### Verify

Open a new PowerShell window:

```powershell
psql --version
psql -U postgres -c "SELECT version();"
```

Enter your superuser password when prompted. You should see `PostgreSQL 16.x`.

### Create a Database for the Project

```powershell
psql -U postgres
```

```sql
CREATE DATABASE communityanalyzer;
CREATE USER causer WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE communityanalyzer TO causer;
\q
```

---

## 19. pgAdmin 4

**Only required if your team chooses database storage.**

### Download

Go to https://www.pgadmin.org/download/pgadmin-4-windows/ and download the Windows installer.

### Installation

1. Run the installer
2. Follow the wizard — default settings are fine
3. On first launch, set a **master password** for pgAdmin (this is separate from the PostgreSQL password)

### Connect to Local PostgreSQL

1. Launch pgAdmin 4 from Start Menu
2. Right-click "Servers" → "Register" → "Server"
3. **General tab:** Name = `Local PostgreSQL`
4. **Connection tab:**
   - Host: `localhost`
   - Port: `5432`
   - Username: `postgres`
   - Password: (your superuser password from Step 18)
   - Check "Save password"
5. Click "Save"

### Verify

Expand the server in the left panel. You should see your `communityanalyzer` database listed under Databases.

---

## Quick Verification Checklist

Run these commands in PowerShell to verify all command-line tools are installed:

```powershell
Write-Host "=== Java ===" -ForegroundColor Cyan
java -version

Write-Host "`n=== Maven ===" -ForegroundColor Cyan
mvn -version

Write-Host "`n=== Git ===" -ForegroundColor Cyan
git --version

Write-Host "`n=== VS Code ===" -ForegroundColor Cyan
code --version

Write-Host "`n=== PostgreSQL (optional) ===" -ForegroundColor Cyan
psql --version 2>$null || Write-Host "Not installed (optional)" -ForegroundColor Yellow

Write-Host "`n=== Graphviz (for PlantUML) ===" -ForegroundColor Cyan
dot -V 2>$null || Write-Host "Not installed — install from graphviz.org" -ForegroundColor Yellow
```

### Expected Result

All tools show their version number. PostgreSQL and Graphviz show "Not installed" only if your team chose file-based storage and does not use PlantUML locally.

---

## Environment Variables Summary

| Variable | Value | Purpose |
|----------|-------|---------|
| `JAVA_HOME` | `C:\tools\jdk-21` | Java runtime for Maven |
| `M2_HOME` | `C:\tools\apache-maven-3.x.x` | Maven home directory |
| `PATH_TO_FX` | `C:\tools\javafx-sdk-23.0.2\lib` | JavaFX libraries (only if not using Maven) |
| `PATH` | Includes `java\bin`, `maven\bin`, `git\bin`, `psql\bin` | Command-line access |
