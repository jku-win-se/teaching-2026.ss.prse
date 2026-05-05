# Git Wizard — SE-Praktikum SS 2026

An interactive command-line tool that guides you through the Git workflow required for this course. It helps you create branches, commit with proper messages, open Pull Requests, merge, and tag releases — step by step.

## Requirements

- **git** installed and configured ([download](https://git-scm.com/downloads))
- **GitHub CLI (`gh`)** installed and authenticated ([download](https://cli.github.com/))
  ```powershell
  gh auth login
  ```
- Run the wizard **from inside your cloned project repository**

## Quick Start

Open PowerShell, navigate to your project, and run:

```powershell
cd C:\path\to\your-project
.\tools\GitWizard.ps1
```

You will see an interactive menu:

```
+------------------------------------------------------------+
|          SE-Praktikum Git Wizard  (SS 2026)                |
|          JKU Linz - Software Engineering                   |
+------------------------------------------------------------+

  1. Start a new feature       (create branch)
  2. Save progress             (commit)
  3. Submit for review         (push + create PR)
  4. Merge & cleanup           (after PR approved)
  5. Create release tag        (R1 / R2 / R3)
  6. Check my status           (branch, changes, PRs)

  ?  Help overview    1?..6?  Help on a specific command
  Q  Quit
```

## Getting Help

From the command line:

```powershell
.\tools\GitWizard.ps1 -Help          # Overview with workflow diagram
.\tools\GitWizard.ps1 -Help 1        # Detailed help for option 1
.\tools\GitWizard.ps1 -Help 3        # Detailed help for option 3
```

From inside the wizard menu, type `?` for an overview or `1?` through `6?` for details on a specific command.

## Typical Workflow

The numbered options follow the natural development cycle. Here is how a typical feature implementation looks:

### Step 1 — Pick an issue and create a branch

Choose option **1**. The wizard will show you the open issues in your repository. Pick one, and the wizard creates a properly named feature branch:

```
feature/BR-02-edit-existing-community
feature/US-005-create-community-dialog
feature/SR-01.1-parse-dblp-xml
```

The branch name is generated automatically from the issue type (`BR`, `SR`, `US`) and title.

### Step 2 — Implement, test, commit

Go to your IDE. Write code, write tests. When you want to save your progress, come back to the wizard and choose option **2**. It will:

- Show you what changed
- Optionally run `mvn clean verify` to check your code
- Ask you to stage files and write a commit message
- Automatically append the issue number (`#42`) to your message

You can repeat this step as many times as needed.

### Step 3 — Push and open a Pull Request

When your feature is complete and tested, choose option **3**. The wizard pushes your branch and creates a Pull Request with a checklist. Then ask a teammate to review it.

### Step 4 — Merge after approval

Once your PR is approved and CI passes, choose option **4**. The wizard merges the PR, deletes the branch (local and remote), and switches you back to `main`.

### Step 5 — Tag a release

On release day (R1, R2, or R3), choose option **5** to create an annotated tag on `main` and push it to GitHub.

### Step 6 — Check your status

At any time, choose option **6** to see your current branch, uncommitted changes, open PRs, and release tags. This command is read-only and never modifies anything.

## Sequence Diagrams

The `diagrams/` folder contains PlantUML sequence diagrams for each workflow:

- `01-start-feature.puml` — Creating a feature branch from an issue
- `02-save-progress.puml` — Committing with tests and issue references
- `03-submit-for-review.puml` — Pushing and opening a Pull Request
- `04-merge-cleanup.puml` — Merging a PR and cleaning up
- `05-create-release-tag.puml` — Tagging a release on main
- `06-full-workflow.puml` — End-to-end feature lifecycle

To render them, paste the `.puml` content into [plantuml.com](https://www.plantuml.com/plantuml/uml/) or use the PlantUML plugin in your IDE.

## Rules to Remember

- **Never commit directly to `main`** — always use a feature branch
- **Every commit must reference an issue** with `#N` in the message
- **Every feature needs a Pull Request** with at least one approving review
- **Commits at least once per week** — regular progress is expected
- **Tag each release** (R1, R2, R3) on `main` before the deadline
