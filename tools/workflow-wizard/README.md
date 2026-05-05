# SE-Praktikum Workflow Wizard

Interactive guide for the correct git workflow in SE-Praktikum SS 2026.

## Quick Start

1. Open a terminal in your project folder (the folder with `pom.xml`)
2. Double-click `wizard.bat` or run:
   ```
   powershell -ExecutionPolicy Bypass -File path\to\prse-wizard.ps1
   ```

## Prerequisites

- [Git](https://git-scm.com/downloads) installed and configured
- [GitHub CLI](https://cli.github.com/) installed and authenticated (`gh auth login`)
- [Maven](https://maven.apache.org/download.cgi) installed (for build verification)

## What it does

The wizard guides you through the correct SE-Praktikum workflow:

1. **Start a User Story** — creates a properly named feature branch
2. **Commit changes** — ensures issue references in commit messages
3. **Push & create PR** — prevents direct pushes to main
4. **Check status** — shows your issues, PRs, and CI status
5. **Create release** — tags and creates a GitHub release
6. **Verify build** — runs Maven and shows test/coverage results

## Rules enforced

- No direct pushes to `main` — always use feature branches and PRs
- Commit messages must reference an issue (`#12`)
- Branch names follow the pattern: `feature/US-NNN-description`
- Releases are tagged: R1, R2, R3, Final
