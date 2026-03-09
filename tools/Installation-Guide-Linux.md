# SE-Praktikum 2026 — Linux Installation Guide

**Course:** Praktikum Software Engineering — SS 2026
**Platform:** Ubuntu 22.04 / 24.04 LTS (instructions adapt easily to Fedora, Arch, etc.)
**Note:** This guide covers native Linux installation (no Docker). Uses `apt` for Ubuntu/Debian. Equivalent commands for other distros are noted where relevant.

---

## Table of Contents

1. [Prerequisites](#1-prerequisites)
2. [Java JDK 21](#2-java-jdk-21)
3. [JavaFX 23.0.2](#3-javafx-2302)
4. [Apache Maven](#4-apache-maven)
5. [SceneBuilder 23.0.1](#5-scenebuilder-2301)
6. [Git](#6-git)
7. [GitHub Desktop](#7-github-desktop)
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

## 1. Prerequisites

Update your system before installing anything:

```bash
sudo apt update && sudo apt upgrade -y
```

Install essential build tools:

```bash
sudo apt install -y curl wget gnupg2 software-properties-common apt-transport-https ca-certificates unzip
```

**Fedora:**

```bash
sudo dnf update -y
sudo dnf install -y curl wget gnupg2 unzip
```

**Arch:**

```bash
sudo pacman -Syu
sudo pacman -S curl wget unzip
```

---

## 2. Java JDK 21

### Option A: Eclipse Temurin via APT (recommended for Ubuntu/Debian)

Add the Adoptium repository:

```bash
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /usr/share/keyrings/adoptium.asc
echo "deb [signed-by=/usr/share/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-21-jdk
```

### Option B: SDKMAN (distro-independent, recommended for multi-JDK setups)

```bash
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 21-tem
```

SDKMAN handles JAVA_HOME and PATH automatically. Switch versions with `sdk use java <version>`.

### Option C: Fedora / Arch

**Fedora:**

```bash
sudo dnf install -y java-21-openjdk-devel
```

**Arch:**

```bash
sudo pacman -S jdk21-openjdk
```

### Set JAVA_HOME (if not using SDKMAN)

Add to `~/.bashrc` (or `~/.zshrc` if using zsh):

```bash
export JAVA_HOME=/usr/lib/jvm/temurin-21-jdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"
```

Find the exact path with:

```bash
update-java-alternatives -l
```

Reload:

```bash
source ~/.bashrc
```

### Verify

```bash
java -version
javac -version
echo $JAVA_HOME
```

Expected output should show `openjdk version "21.x.x"`.

### Troubleshooting

If multiple JDKs are installed, set the default:

```bash
sudo update-alternatives --config java
sudo update-alternatives --config javac
```

Select the JDK 21 entry from the list.

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

Maven downloads the correct platform-specific binaries automatically.

### Manual Download (optional)

1. Go to https://openjfx.io/
2. Download **JavaFX SDK 23.0.2** for Linux (x64)
3. Extract:

```bash
mkdir -p ~/tools
tar xzf openjfx-23.0.2_linux-x64_bin-sdk.tar.gz -C ~/tools/
```

4. Add to `~/.bashrc`:

```bash
export PATH_TO_FX="$HOME/tools/javafx-sdk-23.0.2/lib"
```

### Important: GTK and OpenGL dependencies

JavaFX on Linux requires certain system libraries. Install them:

```bash
sudo apt install -y libgtk-3-0 libgl1-mesa-glx libxtst6 libxxf86vm1
```

**Fedora:**

```bash
sudo dnf install -y gtk3 mesa-libGL libXtst libXxf86vm
```

### Verify

```bash
ls ~/tools/javafx-sdk-23.0.2/lib/*.jar
```

---

## 4. Apache Maven

### Installation via APT

```bash
sudo apt install -y maven
```

Note: Ubuntu repositories may ship an older Maven version. If you need the latest:

### Installation via manual download (latest version)

```bash
MAVEN_VERSION=3.9.9
wget https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
tar xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C ~/tools/
```

Add to `~/.bashrc`:

```bash
export M2_HOME="$HOME/tools/apache-maven-3.9.9"
export PATH="$M2_HOME/bin:$PATH"
```

Reload:

```bash
source ~/.bashrc
```

### Installation via SDKMAN

```bash
sdk install maven
```

### Fedora / Arch

**Fedora:**

```bash
sudo dnf install -y maven
```

**Arch:**

```bash
sudo pacman -S maven
```

### Verify

```bash
mvn -version
```

Ensure it shows Java 21 as the runtime. If not, check `JAVA_HOME`.

---

## 5. SceneBuilder 23.0.1

### Download

Go to https://gluonhq.com/products/scene-builder/ and download the **Linux DEB** or **Linux RPM** package for version 23.0.1.

### Installation (Ubuntu/Debian)

```bash
sudo dpkg -i SceneBuilder-23.0.1.deb
sudo apt install -f   # fix any missing dependencies
```

### Installation (Fedora)

```bash
sudo dnf install SceneBuilder-23.0.1.rpm
```

### Installation (Arch — from DEB via debtap, or use the tarball)

Download the Linux tarball from Gluon, extract, and run manually:

```bash
tar xzf SceneBuilder-23.0.1-linux.tar.gz -C ~/tools/
~/tools/SceneBuilder/bin/SceneBuilder
```

### Integration with VS Code

In VS Code settings, set the SceneBuilder path:

```json
{
    "scenebuilder.path": "/opt/scenebuilder/bin/SceneBuilder"
}
```

The exact path depends on where the DEB/RPM installed it. Find it with:

```bash
which SceneBuilder || find /opt /usr -name "SceneBuilder" 2>/dev/null
```

### Verify

Launch SceneBuilder from the application menu or terminal. You should see the visual editor with a component library on the left.

---

## 6. Git

### Installation

Git is almost certainly already installed. If not:

```bash
sudo apt install -y git
```

**Fedora:**

```bash
sudo dnf install -y git
```

**Arch:**

```bash
sudo pacman -S git
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
git config --list
```

---

## 7. GitHub Desktop

GitHub Desktop does not have an official Linux release. There are two alternatives:

### Option A: Community fork (recommended)

The Shiftkey fork provides Linux packages:

```bash
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" | sudo tee /etc/apt/sources.list.d/shiftkey-packages.list
sudo apt update
sudo apt install -y github-desktop
```

Source: https://github.com/shiftkey/desktop

### Option B: Use GitKraken, VS Code Git, or command-line Git

GitKraken is a polished Git GUI available natively on Linux:

```bash
sudo snap install gitkraken --classic
```

Or download from https://www.gitkraken.com/download.

### Verify

Launch GitHub Desktop (or GitKraken) and sign in with your GitHub account.

---

## 8. Visual Studio Code

### Installation via APT (recommended for Ubuntu/Debian)

```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code
```

### Installation via Snap

```bash
sudo snap install code --classic
```

### Installation (Fedora)

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo
sudo dnf install -y code
```

### Installation (Arch)

```bash
sudo pacman -S code
```

Or from AUR: `yay -S visual-studio-code-bin`

### Essential Extensions

Install all course extensions at once:

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

## 9. SonarQube Community Edition

### Download

Go to https://www.sonarsource.com/open-source-editions/sonarqube-community-edition/ and download the **ZIP distribution**.

### Prerequisites

SonarQube 10.x requires Java 17 (not 21). Install a separate JDK 17:

**Ubuntu (Temurin):**

```bash
sudo apt install -y temurin-17-jdk
```

**SDKMAN:**

```bash
sdk install java 17-tem
```

**Fedora:**

```bash
sudo dnf install -y java-17-openjdk
```

Note the install path:

```bash
update-java-alternatives -l | grep 17
```

### System Requirements

SonarQube requires increased virtual memory limits. Set them:

```bash
sudo sysctl -w vm.max_map_count=524288
sudo sysctl -w fs.file-max=131072
```

Make persistent by adding to `/etc/sysctl.conf`:

```
vm.max_map_count=524288
fs.file-max=131072
```

### Installation

```bash
mkdir -p ~/tools
unzip sonarqube-10.*.zip -d ~/tools/
```

Configure SonarQube to use Java 17. Edit `~/tools/sonarqube-10.x/conf/wrapper.conf`:

```
wrapper.java.command=/usr/lib/jvm/temurin-17-jdk-amd64/bin/java
```

Replace the path with the actual location of your JDK 17 `java` binary.

### Start SonarQube

```bash
cd ~/tools/sonarqube-10.x/bin/linux-x86-64
./sonar.sh start
```

Wait 1–2 minutes for startup. Check status:

```bash
./sonar.sh status
```

Check logs if startup fails:

```bash
tail -f ~/tools/sonarqube-10.x/logs/sonar.log
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
cd ~/tools/sonarqube-10.x/bin/linux-x86-64
./sonar.sh stop
```

### Optional: Create a systemd service

Create `/etc/systemd/system/sonarqube.service`:

```ini
[Unit]
Description=SonarQube Community Edition
After=network.target

[Service]
Type=forking
ExecStart=/home/<your-user>/tools/sonarqube-10.x/bin/linux-x86-64/sonar.sh start
ExecStop=/home/<your-user>/tools/sonarqube-10.x/bin/linux-x86-64/sonar.sh stop
User=<your-user>
LimitNOFILE=131072
LimitNPROC=8192

[Install]
WantedBy=multi-user.target
```

Enable and start:

```bash
sudo systemctl daemon-reload
sudo systemctl enable sonarqube
sudo systemctl start sonarqube
```

---

## 10. SonarLint

SonarLint is a VS Code extension — no separate installation needed.

### Installation

Already installed in Step 8 via:

```bash
code --install-extension SonarSource.sonarlint-vscode
```

### Connect to SonarQube (optional)

In VS Code settings (`Ctrl+,`), search for "SonarLint: Connected Mode" and add:

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

```bash
mvn clean test
```

### View Report

```bash
xdg-open target/site/jacoco/index.html
```

The report shows line, branch, and method coverage for each class.

---

## 12. PlantUML

### Installation via APT

```bash
sudo apt install -y plantuml graphviz
```

**Fedora:**

```bash
sudo dnf install -y plantuml graphviz
```

**Arch:**

```bash
sudo pacman -S plantuml graphviz
```

This installs PlantUML and Graphviz (required dependency) in one step.

### VS Code Integration

Already installed in Step 8 via:

```bash
code --install-extension jebbs.plantuml
```

Create a `.puml` file and press `Alt+D` to preview.

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
xdg-open test.png
```

---

## 13. diagrams.net (draw.io)

### Option A: Browser (no installation)

Go to https://app.diagrams.net/ — works immediately.

### Option B: Desktop Application via Snap

```bash
sudo snap install drawio
```

### Option C: Desktop Application via DEB

Download from https://github.com/jgraph/drawio-desktop/releases — get the `.deb` file:

```bash
sudo dpkg -i drawio-amd64-*.deb
sudo apt install -f
```

### Option D: VS Code Extension

Already installed in Step 8. Create a file with `.drawio` extension — VS Code opens the full editor inline.

### Verify

Create a new diagram, add a UML class element, save as `.drawio` file.

---

## 14. Umlet

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

### Create a desktop launcher (optional)

Create `~/.local/share/applications/umlet.desktop`:

```ini
[Desktop Entry]
Name=Umlet
Exec=java -jar /home/<your-user>/tools/Umlet/umlet.jar
Icon=/home/<your-user>/tools/Umlet/img/umlet_logo.png
Type=Application
Categories=Development;
```

### Online Alternative

Use https://www.umletino.com/ in a browser — no installation required.

### Verify

Launch Umlet. Create a new class diagram by typing in the text panel on the right.

---

## 15. Figma

Figma is browser-based — no installation required.

### Setup

1. Go to https://www.figma.com/
2. Create a free account (sign up with your JKU email)
3. The free plan supports up to 3 projects with unlimited collaborators

### Desktop App (unofficial)

There is no official Linux desktop app. Use the browser version, or install the community Figma Linux app:

```bash
sudo snap install figma-linux
```

Source: https://github.com/nickytonline/figma-linux

### Verify

Create a new design file, add a frame (F), and draw a rectangle (R).

---

## 16. Pencil Project

### Download

Go to https://pencil.evolus.vn/ and download the **Linux DEB** package.

### Installation (Ubuntu/Debian)

```bash
sudo dpkg -i pencil-*.deb
sudo apt install -f
```

### Installation (Fedora — via RPM or AppImage)

Download the AppImage from the Pencil Project website and run directly:

```bash
chmod +x Pencil-*.AppImage
./Pencil-*.AppImage
```

### Verify

Launch Pencil from the application menu. You should see a canvas with a shapes panel on the left.

---

## 17. Penpot

Penpot is browser-based — no installation required.

### Setup

1. Go to https://penpot.app/
2. Click **"Start designing"**
3. Create a free account

### Verify

Create a new project, open a new page, and add shapes.

---

## 18. PostgreSQL 16

**Only required if your team chooses database storage.**

### Installation via APT (Ubuntu/Debian)

Add the official PostgreSQL repository for the latest version:

```bash
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y postgresql-16
```

### Installation (Fedora)

```bash
sudo dnf install -y postgresql16-server postgresql16
sudo postgresql-setup --initdb
```

### Installation (Arch)

```bash
sudo pacman -S postgresql
sudo -u postgres initdb -D /var/lib/postgres/data
```

### Start the Service

```bash
sudo systemctl enable postgresql
sudo systemctl start postgresql
```

### Create a Database for the Project

```bash
sudo -u postgres psql
```

```sql
CREATE DATABASE communityanalyzer;
CREATE USER causer WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE communityanalyzer TO causer;
\q
```

### Verify

```bash
psql --version
sudo -u postgres psql -c "SELECT version();"
```

You should see `PostgreSQL 16.x`.

### Stop the Service

```bash
sudo systemctl stop postgresql
```

---

## 19. pgAdmin 4

**Only required if your team chooses database storage.**

### Installation via APT (Ubuntu/Debian)

Add the pgAdmin repository:

```bash
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pgadmin4.list
sudo apt update
```

Install the desktop version:

```bash
sudo apt install -y pgadmin4-desktop
```

Or the web version (accessible via browser at http://localhost/pgadmin4):

```bash
sudo apt install -y pgadmin4-web
sudo /usr/pgadmin4/bin/setup-web.sh
```

### Installation (Fedora)

```bash
sudo rpm -i https://ftp.postgresql.org/pub/pgadmin/pgadmin4/yum/pgadmin4-fedora-repo-2-1.noarch.rpm
sudo dnf install -y pgadmin4-desktop
```

### Setup

1. Launch pgAdmin 4 from the application menu
2. Set a **master password** for pgAdmin (separate from PostgreSQL password)
3. Right-click "Servers" → "Register" → "Server"
4. **General tab:** Name = `Local PostgreSQL`
5. **Connection tab:**
   - Host: `localhost`
   - Port: `5432`
   - Username: `postgres`
   - Password: (set during PostgreSQL setup, or use peer authentication)
6. Click "Save"

### Verify

Expand the server in the left panel. You should see your `communityanalyzer` database listed under Databases.

---

## Quick Verification Checklist

Run this in Terminal to verify all command-line tools:

```bash
echo "=== Java ==="
java -version

echo -e "\n=== Maven ==="
mvn -version

echo -e "\n=== Git ==="
git --version

echo -e "\n=== VS Code ==="
code --version

echo -e "\n=== PlantUML ==="
plantuml -version 2>/dev/null || echo "Not installed"

echo -e "\n=== Graphviz ==="
dot -V 2>/dev/null || echo "Not installed"

echo -e "\n=== PostgreSQL (optional) ==="
psql --version 2>/dev/null || echo "Not installed (optional)"
```

---

## APT Summary (Ubuntu/Debian)

One-liner to install all CLI tools and dependencies:

```bash
# Add Adoptium repo first (see Step 2), then:
sudo apt install -y \
    temurin-21-jdk \
    temurin-17-jdk \
    git \
    maven \
    plantuml \
    graphviz \
    libgtk-3-0 \
    libgl1-mesa-glx \
    libxtst6 \
    libxxf86vm1
```

GUI applications require separate installation (DEB packages, Snap, or manual download):

```bash
# Snap installs
sudo snap install code --classic
sudo snap install drawio

# DEB installs (download first)
sudo dpkg -i SceneBuilder-23.0.1.deb
sudo dpkg -i pencil-*.deb
sudo apt install -f
```

---

## Environment Variables Summary (~/.bashrc)

```bash
# Java 21 (primary)
export JAVA_HOME=/usr/lib/jvm/temurin-21-jdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"

# Maven (only if manually installed)
# export M2_HOME="$HOME/tools/apache-maven-3.9.9"
# export PATH="$M2_HOME/bin:$PATH"

# JavaFX (only if not using Maven)
# export PATH_TO_FX="$HOME/tools/javafx-sdk-23.0.2/lib"
```

After editing `~/.bashrc`, reload with:

```bash
source ~/.bashrc
```

---

## Linux-Specific Notes

### JavaFX rendering issues

If JavaFX applications show a blank window or crash, try:

```bash
export GDK_BACKEND=x11
```

This forces X11 mode instead of Wayland, which can cause issues with some JavaFX versions.

On **Wayland-based** desktops (GNOME 41+ default), you may also need:

```bash
-Djdk.gtk.version=3
```

Add this as a JVM argument in your Maven run configuration.

### SonarQube: Elasticsearch limits

SonarQube's embedded Elasticsearch requires the `vm.max_map_count` setting (see Step 9). If you forget this, SonarQube will fail to start with an error in the logs about `max virtual memory areas`.

### File watchers limit

VS Code and other tools may hit the Linux file watcher limit. Increase it:

```bash
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

### SourceTree

SourceTree is not available on Linux. Use **GitKraken**, **GitHub Desktop (Shiftkey fork)**, or VS Code's built-in Git + GitLens extension as alternatives.

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
