# Troubleshooting Guide

Common problems and solutions for the SE-Praktikum 2026 demo project.

---

## Java

### `java` is not recognized / wrong version

**Symptom:** `java -version` shows an older version or command not found.

**Fix (Windows):**
```powershell
# Check which Java is on PATH
where.exe java

# If wrong version, update JAVA_HOME and PATH
# System → Environment Variables → JAVA_HOME = C:\path\to\jdk-21
# Restart your terminal after changes
```

**Fix (macOS/Linux):**
```bash
# List installed JDKs
/usr/libexec/java_home -V          # macOS
update-java-alternatives -l        # Linux

# Set in ~/.zshrc or ~/.bashrc
export JAVA_HOME=$(/usr/libexec/java_home -v 21)   # macOS
export JAVA_HOME=/usr/lib/jvm/temurin-21-jdk-amd64  # Linux
source ~/.zshrc
```

### `module-info.java` errors

**Symptom:** Compilation errors related to modules, e.g. `package X is not visible`.

**Fix:** Ensure `module-info.java` is in `src/main/java/` (not inside a package folder) and contains the correct `opens` and `exports` directives for your packages.

---

## Maven

### Maven uses wrong Java version

**Symptom:** `mvn -version` shows Java 17 or another version instead of 21.

**Fix:** Maven reads `JAVA_HOME`. Set it correctly and restart your terminal:
```powershell
# Windows
echo $env:JAVA_HOME
# Should point to JDK 21

# If wrong:
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\path\to\jdk-21", "User")
```

### `BUILD FAILURE` — dependency resolution

**Symptom:** Maven cannot download dependencies. Errors like `Could not resolve dependencies`.

**Fix:**
```bash
# Clear local Maven cache and retry
mvn dependency:purge-local-repository
mvn clean verify
```

If behind a corporate proxy, configure `~/.m2/settings.xml` with proxy settings.

### `-Dsonar.*` parameters not recognized in PowerShell

**Symptom:** Error like `Plugin not found in any plugin repository: .host.url=http://localhost`.

**Fix:** PowerShell interprets `-D` as a PowerShell parameter. Wrap each `-D` argument in double quotes:
```powershell
# WRONG
mvn sonar:sonar -Dsonar.host.url=http://localhost:9000 -Dsonar.token=mytoken

# CORRECT
mvn sonar:sonar "-Dsonar.host.url=http://localhost:9000" "-Dsonar.token=mytoken"
```

This is a PowerShell-only issue. Bash and cmd.exe do not require quotes.

---

## JavaFX

### Application starts but window is blank / crashes

**Fix (Linux — Wayland):** JavaFX may not work correctly on Wayland. Force X11:
```bash
export GDK_BACKEND=x11
mvn javafx:run
```

Or add JVM argument:
```bash
mvn javafx:run -Djavafx.platform=x11
```

**Fix (all platforms):** Ensure JavaFX dependencies in `pom.xml` match your OS. Maven should handle this automatically — if not, delete `~/.m2/repository/org/openjfx/` and rebuild.

### `FXMLLoader` — Location is not set / NullPointerException

**Symptom:** `java.lang.NullPointerException` at `FXMLLoader.load()` or `Location is not set`.

**Fix:** The FXML file is not found at runtime. Check:
1. The FXML file is in `src/main/resources/at/jku/se/` (must mirror the package structure)
2. The resource path in `App.java` matches: `App.class.getResource("main-view.fxml")`
3. The file name is exact (case-sensitive on Linux/macOS)

### SceneBuilder cannot open FXML file

**Symptom:** SceneBuilder shows errors or a blank canvas when opening an FXML file.

**Fix:**
1. Ensure SceneBuilder version matches JavaFX version (23.x with 23.x)
2. If using custom components, SceneBuilder needs them on its classpath — for basic UI elements this should not be an issue
3. Try: File → New, create a simple layout, save, and verify it opens correctly

---

## SonarQube (Docker)

### SonarQube does not start — port already in use

**Symptom:** `docker compose up -d` succeeds but SonarQube is not accessible at `:9000`.

**Fix:** Another service is using port 9000. Check:
```powershell
# Windows
netstat -ano | findstr :9000

# macOS/Linux
lsof -i :9000
```

Change the port in `docker/.env`:
```
SONAR_PORT=9001
```

Then access SonarQube at http://localhost:9001.

### SonarQube crashes immediately — `vm.max_map_count`

**Symptom:** SonarQube container exits with Elasticsearch errors. Logs show `max virtual memory areas vm.max_map_count [65530] is too low`.

**Fix (Windows — Docker Desktop):**
```powershell
wsl -d docker-desktop sysctl -w vm.max_map_count=262144
```

This must be run after every Docker Desktop restart, or add to a startup script.

**Fix (Linux):**
```bash
sudo sysctl -w vm.max_map_count=524288
echo "vm.max_map_count=524288" | sudo tee -a /etc/sysctl.conf
```

**Fix (macOS):** Docker Desktop for Mac handles this automatically. If issues persist, increase Docker Desktop memory allocation in Settings → Resources to at least 4 GB.

### SonarQube — password mismatch after changing `.env`

**Symptom:** SonarQube starts but cannot connect to its database. Logs show `FATAL: password authentication failed for user "sonar"`.

**Fix:** PostgreSQL bakes the password into the volume on first initialization. Changing `SONAR_DB_PASSWORD` in `.env` after the volume exists has no effect.

Delete the volume and restart:
```bash
cd docker
docker compose down
docker volume rm sonar-db-data
docker compose up -d
```

**Warning:** This deletes all SonarQube data (projects, history, settings).

### SonarQube — first login password

**Symptom:** Cannot login to SonarQube.

**Fix:** Default credentials are `admin` / `admin`. On first login, you are forced to change the password. If you forgot your new password:
```bash
cd docker
docker compose down
docker volume rm sonar-db-data sonar-data sonar-extensions sonar-logs
docker compose up -d
```

This resets everything to factory defaults.

---

## SonarQube Analysis (Maven)

### `Not authorized. Please check the properties sonar.login and sonar.password`

**Symptom:** Maven SonarQube analysis fails with 401 Unauthorized.

**Fix:**
1. Verify your token is correct: My Account → Security → Tokens in SonarQube
2. Ensure you are passing the token correctly:
```powershell
mvn sonar:sonar -Psonar "-Dsonar.host.url=http://localhost:9000" "-Dsonar.token=sqa_your_token_here"
```
3. If the token has expired, generate a new one

### `Project not found. Key: community-analyzer-demo`

**Symptom:** SonarQube rejects the analysis because the project does not exist.

**Fix:** SonarQube Community Edition auto-creates projects on first analysis. If you see this error:
1. Check that `sonar.projectKey` in `pom.xml` does not contain special characters
2. Ensure your token has sufficient permissions (use a Global Analysis Token for simplicity)

### JaCoCo coverage shows 0% in SonarQube

**Symptom:** Tests pass and JaCoCo HTML report shows coverage, but SonarQube shows 0%.

**Fix:** SonarQube needs the JaCoCo XML report (not just HTML). Verify:
1. The file `target/site/jacoco/jacoco.xml` exists after `mvn clean verify`
2. The `sonar.coverage.jacoco.xmlReportPaths` property in `pom.xml` points to the correct path
3. Run `mvn clean verify` before `sonar:sonar` (not just `mvn clean compile sonar:sonar`)

---

## JaCoCo

### Coverage report not generated

**Symptom:** `target/site/jacoco/` directory does not exist after `mvn clean verify`.

**Fix:** Ensure the JaCoCo plugin is in `pom.xml` with both `prepare-agent` and `report` executions. The `report` goal must run in the `test` phase (after tests execute).

### Coverage lower than expected

**Symptom:** Coverage percentage is lower than you think it should be.

**Fix:**
1. Open `target/site/jacoco/index.html` and check which classes/methods are not covered
2. Remember: JaCoCo measures branch coverage, not just line coverage. Every `if/else`, `switch`, `try/catch` creates branches
3. UI classes (controllers with `@FXML`) are hard to test without a running JavaFX runtime — focus coverage on model classes

---

## Git / GitHub

### `git push` rejected — behind remote

**Symptom:** `! [rejected] main -> main (non-fast-forward)`.

**Fix:**
```bash
git pull --rebase origin main
# Resolve any conflicts
git push origin main
```

### Merge conflicts in FXML files

**Symptom:** Git shows conflicts in `.fxml` files that are hard to resolve manually.

**Fix:** FXML files are XML — conflicts are usually in element attributes. Best practice:
1. One team member owns the FXML layout at a time
2. Use SceneBuilder to reopen the conflicted file after resolving — it validates the XML
3. If badly broken, take one version entirely and re-apply the other changes manually

### Commit references wrong issue number

**Symptom:** Commit message has wrong `#IssueNr`, linking to the wrong User Story.

**Fix:** You cannot edit pushed commits without force-push (not recommended). Instead, add a comment on the correct GitHub Issue referencing the commit SHA:
```
This was implemented in commit abc1234
```

---

## GitHub Actions

### Workflow does not trigger

**Symptom:** Push to `main` does not start the CI pipeline.

**Fix:**
1. Check that `.github/workflows/ci.yml` exists on the `main` branch (not just locally)
2. Go to **Repository → Actions** tab — check for error messages
3. Ensure the YAML is valid — a syntax error silently disables the workflow

### SonarQube step skipped in GitHub Actions

**Symptom:** The workflow runs but the SonarQube step shows "skipped".

**Fix:** This is expected if you have not configured the secrets. The workflow checks `if: env.SONAR_TOKEN != ''`. To enable:
1. Go to **Repository → Settings → Secrets and variables → Actions**
2. Add `SONAR_TOKEN` and `SONAR_HOST_URL`

Note: For local SonarQube (not publicly accessible), run the analysis locally instead of in GitHub Actions.

### Tests pass locally but fail in CI

**Symptom:** `mvn clean verify` passes on your machine but fails in GitHub Actions.

**Fix:** Common causes:
1. **File paths:** Windows uses `\`, Linux (CI runner) uses `/`. Use `Path.of()` or `Paths.get()` instead of hardcoded separators
2. **File encoding:** Ensure all source files are UTF-8 (set in `pom.xml`: `<project.build.sourceEncoding>UTF-8`)
3. **Locale-dependent tests:** Date formatting, number formatting, string sorting may differ. Use explicit `Locale` in tests
4. **Missing resources:** A file exists on your machine but was not committed to Git. Check with `git status`

---

## Docker Desktop

### Docker Desktop not starting

**Symptom:** Docker Desktop hangs on startup or WSL2 errors on Windows.

**Fix (Windows):**
```powershell
# Restart WSL
wsl --shutdown
# Restart Docker Desktop from Start Menu
```

If persistent, ensure WSL2 is enabled:
```powershell
wsl --install
wsl --set-default-version 2
```

### Containers start but are not accessible

**Symptom:** `docker compose up -d` succeeds, `docker ps` shows containers running, but http://localhost:9000 does not respond.

**Fix:**
1. Wait longer — SonarQube needs 1-2 minutes to initialize
2. Check container health: `docker inspect sonarqube --format '{{.State.Health.Status}}'`
3. Check logs: `docker logs sonarqube`
4. Ensure no firewall is blocking localhost ports

---

## Quick Diagnostic Commands

```bash
# Check all tool versions
java -version
mvn -version
git --version

# Check Docker containers
docker ps
docker logs sonarqube

# Check SonarQube API
curl http://localhost:9000/api/system/status

# Check JaCoCo report exists
ls target/site/jacoco/jacoco.xml

# Full Maven debug output
mvn clean verify -X
```
