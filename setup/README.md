# SE-Praktikum Setup Verification

A minimal Click Counter application to verify that your development environment is correctly configured for the SE-Praktikum 2026 course.

**This is NOT the course project** — it is a setup verification tool that demonstrates the full toolchain working together.

---

## What This Verifies

| Tool | How It's Verified |
|------|-------------------|
| Java 21 | Project compiles |
| JavaFX 23.0.2 | UI window launches with FXML layout |
| Maven | Build, dependency management, plugin execution |
| JUnit 5 | Unit tests run and pass |
| JaCoCo | Coverage report generated in `target/site/jacoco/` |
| GitHub Actions | CI pipeline builds and tests on push |
| SonarQube | Code quality analysis with coverage import |

---

## Quick Start

### 1. Build and Test

```bash
mvn clean verify
```

### 2. View Coverage Report

Open `target/site/jacoco/index.html` in your browser.

### 3. Run the Application

```bash
mvn javafx:run
```

A small window with a counter and two buttons ("+1" and "Reset") should appear.

### 4. SonarQube Analysis (optional)

```bash
cd docker
cp .env.example .env
docker compose up -d
# Wait ~2 minutes, open http://localhost:9000
# Login: admin/admin, change password, create a token
cd ..
mvn clean verify sonar:sonar -Psonar "-Dsonar.host.url=http://localhost:9000" "-Dsonar.token=YOUR_TOKEN"
```

---

## Project Structure

```
se-praktikum-setup/
├── .github/workflows/ci.yml        # GitHub Actions CI pipeline
├── docker/
│   ├── docker-compose.yml          # SonarQube local setup
│   └── .env.example
├── src/
│   ├── main/java/at/jku/se/
│   │   ├── App.java                # JavaFX entry point
│   │   ├── controller/
│   │   │   └── MainController.java # UI event handling
│   │   └── model/
│   │       └── Counter.java        # Data model (3 methods)
│   ├── main/resources/at/jku/se/
│   │   └── main-view.fxml          # UI layout (SceneBuilder)
│   └── test/java/at/jku/se/model/
│       └── CounterTest.java        # Unit tests
├── pom.xml
├── TROUBLESHOOTING.md
└── README.md
```

---

## Checklist

After running all steps, verify:

- [ ] `mvn clean verify` — BUILD SUCCESS
- [ ] `target/site/jacoco/index.html` — Coverage report visible
- [ ] `mvn javafx:run` — Counter window opens
- [ ] SonarQube dashboard — Project appears with coverage (optional)
- [ ] GitHub Actions — CI passes after push (after uploading to GitHub)

If all checks pass, your environment is ready for the course project.

---

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common problems and solutions.

---

## Course Information

| | |
|---|---|
| **Course** | Praktikum Software Engineering — SS 2026 |
| **Course Director** | Univ.-Prof. Dr. Manuel Wimmer |
| **Assistants** | Luca Berardinelli, Abbas Rahimi |
| **Institute** | Institut für Wirtschaftsinformatik — Software Engineering, JKU Linz |