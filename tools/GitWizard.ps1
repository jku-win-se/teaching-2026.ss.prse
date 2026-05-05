<#
.SYNOPSIS
    SE-Praktikum Git Wizard - Interactive Git workflow guide.
.EXAMPLE
    .\GitWizard.ps1
    .\GitWizard.ps1 -Help
    .\GitWizard.ps1 -Help 3
#>
param([switch]$Help, [Parameter(Position=0)][string]$Command)
$ErrorActionPreference = "Continue"

$HelpTexts = @{
"overview" = @"

  SE-Praktikum Git Wizard - Help
  ============================================================
  TYPICAL WORKFLOW:
    1. Start a new feature    Pick an issue, create a branch
    2. Save progress          Code, test, commit (repeat)
    3. Submit for review      Push branch, open a Pull Request
    4. Merge & cleanup        After PR is approved, merge to main
    5. Create release tag     Tag a release (R1, R2, R3)
    6. Check my status        See where you are at any time

  REQUIREMENTS:
    - git (https://git-scm.com/downloads)
    - gh  (https://cli.github.com/) authenticated via: gh auth login
    - Run from inside your cloned project repository

  Type a number followed by ? in the menu (e.g. 1?) for details,
  or run: .\GitWizard.ps1 -Help <number>
"@
"1" = @"

  1. START A NEW FEATURE
  ============================================================
  PURPOSE: Create an isolated feature branch for a specific issue.

  WHAT IT DOES:
    - Shows open issues from GitHub (or lets you enter a number)
    - Generates a branch name from the issue type and title
      Example: feature/BR-02-edit-existing-community
    - Switches to main, pulls latest, creates the new branch

  WHY THIS MATTERS:
    Working on feature branches keeps main stable. Your teammates
    can review your changes before they are merged. This is required
    by the course.

  BRANCH NAMING:
    feature/<TYPE>-<slug>  where TYPE comes from the issue title:
      [BR-02]   -> feature/BR-02-edit-existing-community
      [SR-01.1] -> feature/SR-01.1-parse-dblp-xml
      [US-005]  -> feature/US-005-create-community-dialog

  WHEN TO USE: At the start of each new task. Never commit to main.
"@
"2" = @"

  2. SAVE PROGRESS (COMMIT)
  ============================================================
  PURPOSE: Stage changes, optionally test, and commit with a
  properly formatted message referencing an issue.

  WHAT IT DOES:
    - Shows changed files (git status)
    - Optionally runs mvn clean verify
    - Stages files (all at once or interactively)
    - Creates a commit with format: <message> #<issue-number>

  WHY THIS MATTERS:
    Every commit must reference an issue with #N so GitHub links
    commits to issues. This creates traceability between code and
    requirements. Running mvn verify catches errors early.

  COMMIT MESSAGE FORMAT:
    <what you did> #<issue-number>
    Examples:
      Implement community creation with validation #42
      Fix null pointer in RatingImporter #15
      Add unit tests for CommunityService #8

  WHEN TO USE: After every meaningful chunk of work. Aim for at
  least one commit per working session (min once per week).
"@
"3" = @"

  3. SUBMIT FOR REVIEW (PUSH + CREATE PR)
  ============================================================
  PURPOSE: Upload your branch to GitHub and open a Pull Request
  so your teammates can review your code.

  WHAT IT DOES:
    - Pushes your branch to the remote repository
    - Creates a PR from your branch into main
    - Generates a PR body with a checklist

  WHY THIS MATTERS:
    Pull Requests are the core of collaborative development. They
    let teammates read, review, and catch bugs before code reaches
    main. The course requires a PR per User Story. PRs without a
    review do not satisfy the Definition of Done.

  AFTER CREATING THE PR:
    1. Notify your teammates
    2. Wait for at least one approving review
    3. Wait for CI (GitHub Actions) to pass
    4. Then use option 4 (Merge & Cleanup)

  WHEN TO USE: When your feature is complete and tested.
"@
"4" = @"

  4. MERGE & CLEANUP
  ============================================================
  PURPOSE: Merge an approved PR into main and clean up branches.

  WHAT IT DOES:
    - Lists open PRs and shows status (state, review, CI)
    - Merges the PR with a merge commit
    - Deletes remote and local feature branch
    - Switches back to main and pulls

  PREREQUISITES:
    - At least one approving review
    - CI checks passing (GitHub Actions green)
    - No merge conflicts with main

  IF MERGE FAILS:
    - No reviews -> ask a teammate to review
    - CI failure -> check GitHub Actions tab
    - Conflicts  -> run git merge main on your branch, fix, push

  WHEN TO USE: After your PR has been reviewed and approved.
  Do not merge your own PR without a review.
"@
"5" = @"

  5. CREATE RELEASE TAG
  ============================================================
  PURPOSE: Mark a commit on main as a release milestone.

  WHAT IT DOES:
    - Ensures you are on main
    - Creates an annotated git tag (R1, R2, or R3)
    - Pushes the tag to GitHub

  RELEASE MILESTONES:
    R1 (11.04.2026) - UI Prototype and OO Design
    R2 (16.05.2026) - Prototype Implementation and Unit Tests
    R3 (27.06.2026) - Documentation and Extended Tests

  IMPORTANT:
    - Tag only on main, after all PRs for the release are merged
    - Make sure CI passes before tagging
    - Tag only once per release

  WHEN TO USE: On the release deadline, after all deliverables
  are merged into main.
"@
"6" = @"

  6. CHECK MY STATUS
  ============================================================
  PURPOSE: See a quick overview of your git state without
  making any changes.

  WHAT IT SHOWS:
    - Current branch name
    - Uncommitted file changes
    - Last commit (hash, message, time ago)
    - Commits ahead/behind main
    - Remote branches not merged into main
    - Open Pull Requests
    - Release tags (R1, R2, R3)

  COMMON SITUATIONS:
    "Which branch am I on?"       -> Branch line
    "Did I commit my changes?"    -> Uncommitted line
    "Am I up to date with main?"  -> vs main (0 behind = yes)
    "Any PRs I should review?"    -> Open Pull Requests section

  WHEN TO USE: Anytime. Read-only, never modifies anything.
"@
}

if ($Help) {
    if ($Command -match '^[1-6]$') { Write-Host $HelpTexts[$Command] }
    else { Write-Host $HelpTexts["overview"] }
    exit 0
}

function Write-Banner { param([string]$T,[string]$C="Cyan"); Write-Host ""; Write-Host ("="*60) -F $C; Write-Host "  $T" -F $C; Write-Host ("="*60) -F $C; Write-Host "" }
function Write-Step { param([int]$N,[string]$T); Write-Host "  [$N] " -F Yellow -N; Write-Host $T }
function Write-Explain { param([string]$T); Write-Host "      > " -F DarkGray -N; Write-Host $T -F DarkGray }
function Write-Cmd { param([string]$T); Write-Host "      $ " -F Green -N; Write-Host $T -F White }
function Write-Ok { param([string]$T); Write-Host "  [OK] " -F Green -N; Write-Host $T }
function Write-Err { param([string]$T); Write-Host "  [!!] " -F Red -N; Write-Host $T }
function Write-Warn { param([string]$T); Write-Host "  [!]  " -F Yellow -N; Write-Host $T }
function Confirm-Action { param([string]$P="Proceed?"); Write-Host ""; $a = Read-Host "  $P (y/n)"; return ($a -eq "y" -or $a -eq "Y" -or $a -eq "yes") }
function Get-CurrentBranch { return (git branch --show-current 2>$null) }
function Get-IssueNumber { param([string]$P="Enter the issue number (e.g. 42)"); $n = Read-Host "  $P"; if ($n -match '^\d+$') { return [int]$n }; Write-Err "Invalid: '$n'"; return $null }

function Test-Preflight {
    $ok = $true
    @(@("git","https://git-scm.com/downloads"),@("gh","https://cli.github.com/")) | ForEach-Object {
        if (-not (Get-Command $_[0] -EA SilentlyContinue)) { Write-Err "'$($_[0])' not found. Install: $($_[1])"; $ok = $false }
    }
    $gd = git rev-parse --git-dir 2>$null
    if (-not $gd) { Write-Err "Not inside a git repo. cd to your project first."; $ok = $false }
    if ($ok) { gh auth status 2>&1 | Out-Null; if ($LASTEXITCODE -ne 0) { Write-Err "gh not authenticated. Run: gh auth login"; $ok = $false } }
    return $ok
}

function Start-Feature {
    Write-Banner "Start a New Feature"
    Write-Explain "We create a feature branch so your work stays isolated from"
    Write-Explain "'main' until it is reviewed and approved by your team."
    Write-Host ""
    Write-Host "  How do you want to select the issue?" -F DarkGray
    Write-Host "    L - List open issues and pick one" -F DarkGray
    Write-Host "    N - I already know the issue number" -F DarkGray
    Write-Host ""
    $mode = Read-Host "  Choose (L/N)"
    $issueNum = $null; $issueTitle = $null
    if ($mode -eq "L" -or $mode -eq "l") {
        Write-Host ""; Write-Host "  Open issues:" -F Cyan
        Write-Host ("  " + ("-"*56)) -F DarkGray
        $issues = gh issue list --state open --limit 30 --json number,title,labels 2>$null | ConvertFrom-Json
        if (-not $issues -or $issues.Count -eq 0) { Write-Warn "No open issues found."; return }
        foreach ($iss in $issues) {
            $labels = ""; if ($iss.labels -and $iss.labels.Count -gt 0) { $labels = " [" + (($iss.labels | ForEach-Object { $_.name }) -join ", ") + "]" }
            $n = ("#" + $iss.number).PadRight(6); Write-Host "    $n $($iss.title)" -N
            if ($labels) { Write-Host $labels -F DarkGray -N }; Write-Host ""
        }
        Write-Host ""
        $issueNum = Get-IssueNumber "Pick an issue number from the list above"
        if (-not $issueNum) { return }
        $sel = $issues | Where-Object { $_.number -eq $issueNum }
        if ($sel) { $issueTitle = $sel.title }
    } else {
        $issueNum = Get-IssueNumber "Enter the issue number (e.g. 42)"
        if (-not $issueNum) { return }
        $d = gh issue view $issueNum --json title 2>$null | ConvertFrom-Json
        if ($d) { $issueTitle = $d.title }
    }
    $prefix = ""
    if ($issueTitle -match '\[(US-\d+)\]') { $prefix = $Matches[1] }
    elseif ($issueTitle -match '\[(SR-[\d\.]+)\]') { $prefix = $Matches[1] }
    elseif ($issueTitle -match '\[(BR-\d+)\]') { $prefix = $Matches[1] }
    if ($issueTitle) {
        $slug = $issueTitle.ToLower() -replace '\[.*?\]','' -replace '[^a-z0-9]+','-' -replace '^-','' -replace '-$','' -replace '-+','-'
        if ($slug.Length -gt 40) { $slug = $slug.Substring(0,40) -replace '-$','' }
        if ($prefix) { $branchName = "feature/$prefix-$slug" } else { $branchName = "feature/$issueNum-$slug" }
        Write-Host ""; Write-Host "  Issue:  #$issueNum - $issueTitle" -F Cyan
    } else {
        $desc = Read-Host "  Short description (e.g. create-community)"
        $desc = $desc.Trim().ToLower() -replace '[^a-z0-9\-]','-' -replace '-+','-' -replace '^-','' -replace '-$',''
        if (-not $desc) { Write-Err "Description cannot be empty."; return }
        $branchName = "feature/$issueNum-$desc"
    }
    Write-Host "  Branch: $branchName" -F Cyan; Write-Host ""
    Write-Explain "This will: switch to main, pull latest changes, and create the branch."
    if (-not (Confirm-Action)) { return }
    git checkout main 2>$null
    if ($LASTEXITCODE -ne 0) { Write-Err "Could not switch to main. Uncommitted changes?"; return }
    git pull origin main 2>$null
    git checkout -b $branchName 2>$null
    if ($LASTEXITCODE -ne 0) { Write-Err "Could not create branch '$branchName'. May already exist."; return }
    Write-Host ""; Write-Ok "Feature branch '$branchName' created!"
    Write-Host ""; Write-Host "  Now go to your IDE: implement your feature and write unit tests." -F DarkGray
    Write-Host "  When ready, come back here and use option 2 (Save Progress)." -F DarkGray
}

function Save-Progress {
    Write-Banner "Save Progress (Commit)"
    $branch = Get-CurrentBranch
    if ($branch -eq "main") { Write-Err "You are on 'main'. Switch to your feature branch first."; return }
    Write-Host "  Current branch: $branch" -F Cyan; Write-Host ""
    Write-Step 1 "Check what has changed"; Write-Cmd "git status"; Write-Host ""; git status --short; Write-Host ""
    $changes = git status --porcelain; if (-not $changes) { Write-Warn "No changes detected."; return }
    Write-Step 2 "Run tests before committing (recommended)"
    Write-Explain "This ensures your code compiles and tests pass."
    if (Confirm-Action "Run 'mvn clean verify' now?") {
        $mvnResult = $null; $hasMvn = Get-Command "mvn" -EA SilentlyContinue
        if (-not $hasMvn) { if (Test-Path ".\mvnw.cmd") { & .\mvnw.cmd clean verify; $mvnResult = $LASTEXITCODE } else { Write-Warn "Maven not found. Skipping." } }
        else { mvn clean verify; $mvnResult = $LASTEXITCODE }
        if ($mvnResult -ne $null -and $mvnResult -ne 0) { Write-Err "Maven build FAILED."; if (-not (Confirm-Action "Commit anyway? (not recommended)")) { return } }
        elseif ($mvnResult -eq 0) { Write-Ok "Build successful! Tests passed." }
    }
    Write-Step 3 "Stage your changes"
    Write-Host "    A - Add all changes (git add .)" -F DarkGray; Write-Host "    S - Select files interactively (git add -p)" -F DarkGray
    $sc = Read-Host "  Choose (A/S)"; if ($sc -eq "S" -or $sc -eq "s") { git add -p } else { git add . }
    Write-Step 4 "Write a commit message"
    Write-Explain "Your message MUST reference the issue number with #N."
    Write-Explain "Example: Implement community creation with validation #42"; Write-Host ""
    $issueNum = Get-IssueNumber "Issue number this commit relates to"; if (-not $issueNum) { return }
    $commitMsg = Read-Host "  Commit message (without the #number, we add it)"; $commitMsg = $commitMsg.Trim()
    if (-not $commitMsg) { Write-Err "Message cannot be empty."; return }
    $fullMsg = "$commitMsg #$issueNum"
    Write-Host ""; Write-Host "  Full message: " -N; Write-Host $fullMsg -F Cyan; Write-Host ""
    Write-Cmd "git commit -m `"$fullMsg`""
    if (-not (Confirm-Action)) { return }
    git commit -m "$fullMsg"; if ($LASTEXITCODE -ne 0) { Write-Err "Commit failed."; return }
    Write-Ok "Committed! Progress saved locally."
    Write-Host "  Next: option 3 (Submit for Review) when ready" -F DarkGray
}

function Submit-ForReview {
    Write-Banner "Submit for Review (Push + Create PR)"
    $branch = Get-CurrentBranch
    if ($branch -eq "main") { Write-Err "You are on 'main'. Switch to your feature branch first."; return }
    Write-Host "  Current branch: $branch" -F Cyan; Write-Host ""
    $changes = git status --porcelain
    if ($changes) { Write-Warn "Uncommitted changes found."; git status --short; Write-Host ""; if (-not (Confirm-Action "Push anyway?")) { return } }
    Write-Step 1 "Push your branch to GitHub"; Write-Cmd "git push -u origin $branch"
    if (-not (Confirm-Action)) { return }
    git push -u origin $branch; if ($LASTEXITCODE -ne 0) { Write-Err "Push failed."; return }
    Write-Ok "Branch pushed."
    Write-Step 2 "Create a Pull Request"; Write-Explain "A PR lets your teammates review your code before merging."; Write-Host ""
    $prTitle = Read-Host "  PR title (e.g. 'Implement community creation (BR-01)')"; $prTitle = $prTitle.Trim()
    if (-not $prTitle) { Write-Err "PR title cannot be empty."; return }
    Write-Host ""; Write-Host "  PR: $branch -> main" -F DarkGray; Write-Host "  Title: $prTitle" -F DarkGray; Write-Host ""
    if (-not (Confirm-Action)) { return }
    $issueRef = ""; if ($branch -match '(\d+)') { $issueRef = "`n`nRelates to #$($Matches[1])" }
    $prBody = "## Changes`n`n- $prTitle`n`n## Checklist`n`n- [ ] Code compiles`n- [ ] Unit tests pass (mvn clean verify)`n- [ ] Issue number in commits`n- [ ] Javadoc for public methods$issueRef"
    gh pr create --base main --title "$prTitle" --body "$prBody"
    if ($LASTEXITCODE -ne 0) { Write-Err "PR creation failed."; return }
    Write-Host ""; Write-Ok "Pull Request created!"
    Write-Host "  Next: ask a teammate to review, then use option 4" -F DarkGray
}

function Merge-AndCleanup {
    Write-Banner "Merge & Cleanup"
    $branch = Get-CurrentBranch; Write-Host "  Current branch: $branch" -F Cyan; Write-Host ""
    Write-Step 1 "Open Pull Requests"; gh pr list; Write-Host ""
    $prNum = Read-Host "  PR number to merge"; if (-not ($prNum -match '^\d+$')) { Write-Err "Invalid PR number."; return }
    Write-Step 2 "Check PR status"
    $pi = gh pr view $prNum --json state,reviewDecision,statusCheckRollup 2>$null | ConvertFrom-Json
    if ($pi) {
        $ci = "no checks"; if ($pi.statusCheckRollup -and $pi.statusCheckRollup.Count -gt 0) { $ci = $pi.statusCheckRollup[0].conclusion; if (-not $ci) { $ci = "pending" } }
        $rv = $pi.reviewDecision; if (-not $rv) { $rv = "no reviews yet" }
        Write-Host "  State: $($pi.state)  |  Review: $rv  |  CI: $ci" -F DarkGray
    }; Write-Host ""
    Write-Step 3 "Merge the PR"; Write-Cmd "gh pr merge $prNum --merge --delete-branch"
    if (-not (Confirm-Action "Merge PR #$prNum ?")) { return }
    gh pr merge $prNum --merge --delete-branch; if ($LASTEXITCODE -ne 0) { Write-Err "Merge failed."; return }
    Write-Step 4 "Back to main"; git checkout main; git pull origin main
    if ($branch -ne "main" -and $branch) { git branch -d $branch 2>$null }
    Write-Host ""; Write-Ok "PR #$prNum merged! Your feature is on main."
}

function New-ReleaseTag {
    Write-Banner "Create Release Tag"; Write-Explain "Each release (R1, R2, R3) must be tagged on main."
    $branch = Get-CurrentBranch
    if ($branch -ne "main") { Write-Warn "You are on '$branch', not 'main'."; if (-not (Confirm-Action "Switch to main?")) { return }; git checkout main; git pull origin main }
    Write-Host ""; Write-Host "    R1 - UI Prototype and OO Design" -F DarkGray
    Write-Host "    R2 - Prototype Implementation and Unit Tests" -F DarkGray; Write-Host "    R3 - Documentation and Extended Tests" -F DarkGray; Write-Host ""
    $tag = (Read-Host "  Enter release tag (e.g. R2)").Trim().ToUpper()
    if ($tag -notmatch '^R[1-3]$') { Write-Err "Invalid. Use R1, R2, or R3."; return }
    $existing = git tag -l $tag
    if ($existing) { Write-Warn "Tag '$tag' exists!"; if (-not (Confirm-Action "Delete and re-create?")) { return }; git tag -d $tag; git push origin ":refs/tags/$tag" 2>$null }
    $tagMsg = "Release $tag - SE-Praktikum SS 2026"; Write-Cmd "git tag -a $tag -m `"$tagMsg`""
    if (-not (Confirm-Action)) { return }
    git tag -a $tag -m "$tagMsg"; git push origin $tag
    if ($LASTEXITCODE -ne 0) { Write-Err "Failed to push tag."; return }
    Write-Host ""; Write-Ok "Release tag '$tag' created and pushed!"
}

function Show-Status {
    Write-Banner "Current Status"; $branch = Get-CurrentBranch
    Write-Host "  Branch:          $branch" -F Cyan
    $ch = (git status --porcelain | Measure-Object).Count
    if ($ch -gt 0) { Write-Host "  Uncommitted:     $ch file(s)" -F Yellow } else { Write-Host "  Uncommitted:     none (clean)" -F Green }
    Write-Host "  Last commit:     $(git log -1 --format='%h %s (%ar)' 2>$null)" -F DarkGray
    if ($branch -ne "main") { $a = (git rev-list "main..$branch" 2>$null | Measure-Object).Count; $b = (git rev-list "$branch..main" 2>$null | Measure-Object).Count; Write-Host "  vs main:         $a ahead, $b behind" -F DarkGray }
    Write-Host ""; Write-Host "  Remote branches:" -F DarkGray; git branch -r --no-merged main 2>$null | ForEach-Object { Write-Host "    $_" -F DarkGray }
    Write-Host ""; Write-Host "  Open Pull Requests:" -F DarkGray
    $prs = gh pr list --json number,title,author 2>$null | ConvertFrom-Json
    if ($prs -and $prs.Count -gt 0) { foreach ($pr in $prs) { Write-Host "    #$($pr.number) $($pr.title) (by $($pr.author.login))" -F DarkGray } } else { Write-Host "    none" -F DarkGray }
    Write-Host ""; Write-Host "  Release tags:" -F DarkGray; $tags = git tag -l "R*" 2>$null
    if ($tags) { $tags | ForEach-Object { Write-Host "    $_" -F DarkGray } } else { Write-Host "    none yet" -F DarkGray }; Write-Host ""
}

if (-not (Test-Preflight)) { Write-Host ""; Write-Host "Fix the issues above and try again." -F Red; exit 1 }
do {
    Clear-Host; Write-Host ""
    Write-Host "+------------------------------------------------------------+" -F Cyan
    Write-Host "|          SE-Praktikum Git Wizard  (SS 2026)                |" -F Cyan
    Write-Host "|          JKU Linz - Software Engineering                   |" -F Cyan
    Write-Host "+------------------------------------------------------------+" -F Cyan; Write-Host ""
    Write-Host "  1. Start a new feature       (create branch)" -F White
    Write-Host "  2. Save progress             (commit)" -F White
    Write-Host "  3. Submit for review         (push + create PR)" -F White
    Write-Host "  4. Merge & cleanup           (after PR approved)" -F White
    Write-Host "  5. Create release tag        (R1 / R2 / R3)" -F White
    Write-Host "  6. Check my status           (branch, changes, PRs)" -F White; Write-Host ""
    Write-Host "  ?  Help overview    1?..6?  Help on a specific command" -F DarkGray
    Write-Host "  Q  Quit" -F DarkGray; Write-Host ""
    $choice = Read-Host "  Choose an option"
    switch -Regex ($choice) {
        '^[1-6]\?$' { $num = $choice.Substring(0,1); Write-Host $HelpTexts[$num] }
        '^\?$'      { Write-Host $HelpTexts["overview"] }
        '^help$'    { Write-Host $HelpTexts["overview"] }
        '^1$' { Start-Feature } '^2$' { Save-Progress } '^3$' { Submit-ForReview }
        '^4$' { Merge-AndCleanup } '^5$' { New-ReleaseTag } '^6$' { Show-Status }
        '^[Qq]$' { Write-Host "  Bye!" -F Cyan; break }
        default { Write-Warn "Invalid option. Type ? for help." }
    }
    if ($choice -ne "Q" -and $choice -ne "q") { Write-Host ""; Read-Host "  Press Enter to return to the menu" }
} while ($choice -ne "Q" -and $choice -ne "q")
