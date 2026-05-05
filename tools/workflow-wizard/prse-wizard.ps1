# SE-Praktikum Workflow Wizard
# Interactive guide for the correct git workflow in SE-Praktikum SS 2026, JKU Linz.
# PowerShell 5.1 compatible.

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

$script:CachedRepoName = $null

function Write-Color {
    param(
        [Parameter(Mandatory)] [string]$Text,
        [string]$Color = 'White',
        [switch]$NoNewline
    )
    if ($NoNewline) {
        Write-Host $Text -ForegroundColor $Color -NoNewline
    } else {
        Write-Host $Text -ForegroundColor $Color
    }
}

function Read-YesNo {
    param(
        [Parameter(Mandatory)] [string]$Prompt,
        [string]$Default = 'n'
    )
    while ($true) {
        Write-Host ("{0} (y/n) " -f $Prompt) -NoNewline -ForegroundColor White
        $ans = Read-Host
        if ([string]::IsNullOrWhiteSpace($ans)) { $ans = $Default }
        switch -Regex ($ans.Trim().ToLower()) {
            '^(y|yes)$' { return $true }
            '^(n|no)$'  { return $false }
            default     { Write-Color "Please answer y or n." 'Yellow' }
        }
    }
}

function Pause-Menu {
    Write-Host ''
    Write-Color 'Press Enter to return to the menu...' 'DarkGray'
    [void](Read-Host)
}

function Test-Command {
    param([Parameter(Mandatory)] [string]$Name)
    $null = Get-Command $Name -ErrorAction SilentlyContinue
    return $?
}

function Invoke-Git {
    param([Parameter(Mandatory)] [string[]]$Args)
    try {
        $output = & git @Args 2>&1
        return @{ Output = $output; ExitCode = $LASTEXITCODE }
    } catch {
        return @{ Output = $_.Exception.Message; ExitCode = 1 }
    }
}

function Invoke-Gh {
    param([Parameter(Mandatory)] [string[]]$Args)
    try {
        $output = & gh @Args 2>&1
        return @{ Output = $output; ExitCode = $LASTEXITCODE }
    } catch {
        return @{ Output = $_.Exception.Message; ExitCode = 1 }
    }
}

function Get-CurrentBranch {
    $r = Invoke-Git @('branch', '--show-current')
    if ($r.ExitCode -ne 0) { return '(unknown)' }
    return ($r.Output | Out-String).Trim()
}

function Get-RepoName {
    if ($script:CachedRepoName) { return $script:CachedRepoName }
    $r = Invoke-Gh @('repo', 'view', '--json', 'nameWithOwner', '-q', '.nameWithOwner')
    if ($r.ExitCode -eq 0) {
        $script:CachedRepoName = ($r.Output | Out-String).Trim()
    } else {
        $script:CachedRepoName = '(no remote / gh not authenticated)'
    }
    return $script:CachedRepoName
}

function Get-UncommittedCount {
    $r = Invoke-Git @('status', '--porcelain')
    if ($r.ExitCode -ne 0) { return 0 }
    $lines = @($r.Output | Where-Object { $_ -and ($_.ToString().Trim().Length -gt 0) })
    return $lines.Count
}

function Sanitize-BranchPart {
    param([Parameter(Mandatory)] [string]$Text)
    $t = $Text.ToLower()
    $t = ($t -replace '[^a-z0-9]+', '-').Trim('-')
    if ($t.Length -gt 40) { $t = $t.Substring(0, 40).TrimEnd('-') }
    if ([string]::IsNullOrWhiteSpace($t)) { $t = 'work' }
    return $t
}

function Format-IssueNumber {
    param([Parameter(Mandatory)] [int]$Number)
    return ('{0:D3}' -f $Number)
}

# ---------------------------------------------------------------------------
# Prerequisites
# ---------------------------------------------------------------------------

function Test-Prerequisites {
    Write-Color '--- Checking prerequisites ---' 'Cyan'

    $hardFail = $false

    if (-not (Test-Command 'git')) {
        Write-Color 'ERROR: git not found. Install Git: https://git-scm.com/downloads' 'Red'
        $hardFail = $true
    } else {
        Write-Color '  OK: git' 'Green'
    }

    if (-not (Test-Command 'gh')) {
        Write-Color 'ERROR: gh not found. Install GitHub CLI: https://cli.github.com/' 'Red'
        $hardFail = $true
    } else {
        Write-Color '  OK: gh' 'Green'
    }

    if (-not (Test-Command 'mvn')) {
        Write-Color '  WARNING: mvn not found. Some steps will be unavailable.' 'Yellow'
    } else {
        Write-Color '  OK: mvn' 'Green'
    }

    if (-not (Test-Command 'java')) {
        Write-Color '  WARNING: java not found. Build steps may fail.' 'Yellow'
    } else {
        Write-Color '  OK: java' 'Green'
    }

    if (-not (Test-Path '.git')) {
        Write-Color 'ERROR: No .git folder in current directory.' 'Red'
        Write-Color 'Please run this script from inside your project repository.' 'Red'
        $hardFail = $true
    } else {
        Write-Color '  OK: .git found' 'Green'
    }

    if (Test-Command 'gh') {
        $r = Invoke-Gh @('auth', 'status')
        if ($r.ExitCode -ne 0) {
            Write-Color 'ERROR: gh is not authenticated. Please run: gh auth login' 'Red'
            $hardFail = $true
        } else {
            Write-Color '  OK: gh authenticated' 'Green'
        }
    }

    if ($hardFail) {
        Write-Host ''
        Write-Color 'Prerequisites failed. Fix the issues above and try again.' 'Red'
        exit 1
    }
    Write-Host ''
}

# ---------------------------------------------------------------------------
# Menu header
# ---------------------------------------------------------------------------

function Show-Header {
    $branch = Get-CurrentBranch
    $repo = Get-RepoName
    $changes = Get-UncommittedCount

    Clear-Host
    Write-Color '============================================' 'Cyan'
    Write-Color '  SE-Praktikum Workflow Wizard' 'Cyan'
    Write-Color '  Course: Praktikum SE - SS 2026, JKU Linz' 'Cyan'
    Write-Color '============================================' 'Cyan'
    Write-Host ''
    Write-Host ('  Current branch: ') -NoNewline; Write-Color $branch 'Yellow'
    Write-Host ('  Repo: ') -NoNewline; Write-Color $repo 'Yellow'
    Write-Host ('  Uncommitted changes: ') -NoNewline; Write-Color ("{0} files" -f $changes) 'Yellow'
    Write-Host ''
    Write-Color '  1. Start working on a User Story' 'White'
    Write-Color '  2. Commit changes' 'White'
    Write-Color '  3. Push & create Pull Request' 'White'
    Write-Color '  4. Check project status' 'White'
    Write-Color '  5. Create release tag' 'White'
    Write-Color '  6. Verify build (mvn clean verify)' 'White'
    Write-Color '  0. Exit' 'White'
    Write-Host ''
}

# ---------------------------------------------------------------------------
# Option 1: Start working on a User Story
# ---------------------------------------------------------------------------

function Invoke-StartUserStory {
    Write-Host ''
    Write-Color '--- Start Working on a User Story ---' 'Cyan'
    Write-Host ''
    Write-Color '[Step 1/4] Checking current branch...' 'Cyan'

    $branch = Get-CurrentBranch
    if ($branch -ne 'main') {
        Write-Color ("You are currently on branch '{0}'." -f $branch) 'Yellow'
        if (-not (Read-YesNo 'Do you want to switch to main first?')) {
            return
        }
        if ((Get-UncommittedCount) -gt 0) {
            Write-Color 'You have uncommitted changes. Please commit or stash them first.' 'Red'
            return
        }
        $r = Invoke-Git @('checkout', 'main')
        Write-Host ($r.Output | Out-String)
        if ($r.ExitCode -ne 0) {
            Write-Color 'Failed to switch to main.' 'Red'
            return
        }
    }

    Write-Host ''
    Write-Color '[Step 2/4] Updating main branch...' 'Cyan'
    $r = Invoke-Git @('pull', 'origin', 'main')
    Write-Host ($r.Output | Out-String)
    if ($r.ExitCode -ne 0) {
        Write-Color 'git pull failed (possible conflicts). Resolve and try again.' 'Red'
        return
    }

    Write-Host ''
    Write-Color '[Step 3/4] Fetching your assigned User Stories...' 'Cyan'
    $r = Invoke-Gh @('issue', 'list', '--assignee', '@me', '--state', 'open', '--json', 'number,title,labels', '--limit', '30')
    if ($r.ExitCode -ne 0) {
        Write-Color 'Failed to fetch issues. Make sure you are authenticated: gh auth login' 'Red'
        Write-Host ($r.Output | Out-String)
        return
    }

    $json = ($r.Output | Out-String).Trim()
    if (-not $json) { $json = '[]' }
    try {
        $issues = $json | ConvertFrom-Json
    } catch {
        Write-Color 'Could not parse issues list.' 'Red'
        return
    }

    if (-not $issues -or $issues.Count -eq 0) {
        Write-Color 'No open issues assigned to you. Ask your team leader to assign you a User Story.' 'Yellow'
        return
    }

    Write-Host ''
    Write-Color 'Your open issues:' 'White'
    for ($i = 0; $i -lt $issues.Count; $i++) {
        $it = $issues[$i]
        Write-Host ('  {0}. #{1}  {2}' -f ($i + 1), $it.number, $it.title)
    }
    Write-Host ''
    Write-Host 'Select an issue number (or 0 to cancel): ' -NoNewline -ForegroundColor White
    $sel = Read-Host
    if ($sel -notmatch '^\d+$') {
        Write-Color 'Invalid selection.' 'Yellow'
        return
    }
    $selN = [int]$sel
    if ($selN -eq 0) { return }
    if ($selN -lt 1 -or $selN -gt $issues.Count) {
        Write-Color 'Selection out of range.' 'Yellow'
        return
    }
    $chosen = $issues[$selN - 1]

    Write-Host ''
    Write-Color '[Step 4/4] Creating feature branch...' 'Cyan'

    $title = [string]$chosen.title
    $usMatch = [regex]::Match($title, '^\s*\[?US[-\s]?(\d+)[\]\s:.\-]*(.*)$', 'IgnoreCase')
    if ($usMatch.Success) {
        $usNum = Format-IssueNumber ([int]$usMatch.Groups[1].Value)
        $rest = $usMatch.Groups[2].Value
        $slug = Sanitize-BranchPart $rest
        $branchName = "feature/US-$usNum-$slug"
    } else {
        $slug = Sanitize-BranchPart $title
        $branchName = "feature/issue-$($chosen.number)-$slug"
    }

    Write-Host ('Creating branch: ') -NoNewline; Write-Color $branchName 'Yellow'
    if (-not (Read-YesNo 'Proceed?')) { return }

    $r = Invoke-Git @('checkout', '-b', $branchName)
    Write-Host ($r.Output | Out-String)
    if ($r.ExitCode -ne 0) {
        Write-Color 'Failed to create branch.' 'Red'
        return
    }

    Write-Color 'Branch created! You can now start working on your User Story.' 'Green'
    Write-Color ("Tip: Remember to commit frequently and reference #{0} in your commit messages." -f $chosen.number) 'Green'
}

# ---------------------------------------------------------------------------
# Option 2: Commit changes
# ---------------------------------------------------------------------------

function Invoke-Commit {
    Write-Host ''
    Write-Color '--- Commit Changes ---' 'Cyan'
    Write-Host ''
    Write-Color '[Step 1/4] Checking for changes...' 'Cyan'

    $r = Invoke-Git @('status', '--porcelain')
    $rawLines = @()
    if ($r.Output) {
        $rawLines = @(($r.Output | Out-String) -split "`r?`n" | Where-Object { $_.Length -gt 0 })
    }
    if ($rawLines.Count -eq 0) {
        Write-Color 'No changes to commit.' 'Yellow'
        return
    }

    Write-Host ''
    Write-Color '[Step 2/4] Your changes:' 'Cyan'
    Write-Host ''
    foreach ($line in $rawLines) {
        if ($line.Length -lt 3) { continue }
        $code = $line.Substring(0, 2)
        $path = $line.Substring(3)
        $color = 'White'
        $label = '       '
        if ($code -match 'M') { $color = 'Yellow'; $label = 'Modified' }
        elseif ($code -match 'A' -or $code -match '\?') { $color = 'Green'; $label = 'New file' }
        elseif ($code -match 'D') { $color = 'Red'; $label = 'Deleted ' }
        elseif ($code -match 'R') { $color = 'Yellow'; $label = 'Renamed ' }
        Write-Host ('  ') -NoNewline
        Write-Host ($label + ': ') -NoNewline -ForegroundColor $color
        Write-Host $path
    }
    Write-Host ''
    Write-Host ("  {0} file(s) changed" -f $rawLines.Count)

    Write-Host ''
    Write-Color '[Step 3/4] Staging files...' 'Cyan'
    Write-Host 'Stage all changes? (y/n/select) ' -NoNewline -ForegroundColor White
    $ans = (Read-Host).Trim().ToLower()

    if ($ans -eq 'n' -or $ans -eq 'no') {
        return
    } elseif ($ans -eq 'select') {
        for ($i = 0; $i -lt $rawLines.Count; $i++) {
            Write-Host ('  {0}. {1}' -f ($i + 1), $rawLines[$i])
        }
        Write-Host 'Enter file numbers separated by spaces: ' -NoNewline
        $picks = (Read-Host).Trim()
        $nums = @()
        foreach ($p in ($picks -split '\s+')) {
            if ($p -match '^\d+$') { $nums += [int]$p }
        }
        if ($nums.Count -eq 0) {
            Write-Color 'No files selected.' 'Yellow'
            return
        }
        foreach ($n in $nums) {
            if ($n -lt 1 -or $n -gt $rawLines.Count) { continue }
            $line = $rawLines[$n - 1]
            $path = $line.Substring(3)
            $rg = Invoke-Git @('add', '--', $path)
            if ($rg.ExitCode -ne 0) {
                Write-Color ("Failed to stage: {0}" -f $path) 'Red'
            }
        }
    } else {
        $rg = Invoke-Git @('add', '.')
        if ($rg.ExitCode -ne 0) {
            Write-Color 'git add failed.' 'Red'
            Write-Host ($rg.Output | Out-String)
            return
        }
    }

    $stagedCheck = Invoke-Git @('diff', '--cached', '--name-only')
    $stagedLines = @(($stagedCheck.Output | Out-String) -split "`r?`n" | Where-Object { $_.Length -gt 0 })
    if ($stagedLines.Count -eq 0) {
        Write-Color 'Nothing staged. Aborting.' 'Yellow'
        return
    }

    Write-Host ''
    Write-Color '[Step 4/4] Enter commit message:' 'Cyan'

    $message = $null
    while ($true) {
        Write-Host 'Message: ' -NoNewline -ForegroundColor White
        $msg = Read-Host
        if ([string]::IsNullOrWhiteSpace($msg)) {
            Write-Color 'Message must not be empty.' 'Red'
            continue
        }
        if ($msg -notmatch '#\d+') {
            Write-Color 'Commit message must reference an issue (e.g., #12)' 'Red'
            Write-Color 'Example: Implement community CRUD operations #12' 'DarkGray'
            continue
        }
        if ($msg.Length -lt 10) {
            Write-Color 'Warning: message is very short (< 10 chars).' 'Yellow'
        }
        if ($msg.Length -gt 72) {
            Write-Color 'Warning: first line is longer than 72 chars.' 'Yellow'
        }
        $message = $msg
        break
    }

    Write-Host ''
    Write-Color 'Commit preview:' 'White'
    Write-Host ('  Branch:  ') -NoNewline; Write-Color (Get-CurrentBranch) 'Yellow'
    Write-Host ('  Message: ') -NoNewline; Write-Color $message 'Yellow'
    Write-Host ('  Files:   ') -NoNewline; Write-Color ("{0} staged" -f $stagedLines.Count) 'Yellow'
    Write-Host ''
    if (-not (Read-YesNo 'Proceed?')) {
        Write-Color 'Cancelled. Staged files remain staged.' 'Yellow'
        return
    }

    $r = Invoke-Git @('commit', '-m', $message)
    Write-Host ($r.Output | Out-String)
    if ($r.ExitCode -ne 0) {
        Write-Color 'Commit failed.' 'Red'
        return
    }
    Write-Color 'Changes committed successfully!' 'Green'
    Write-Color 'Tip: Use option 3 to push and create a Pull Request when ready.' 'Green'
}

# ---------------------------------------------------------------------------
# Option 3: Push & Create Pull Request
# ---------------------------------------------------------------------------

function Invoke-PushPR {
    Write-Host ''
    Write-Color '--- Push & Create Pull Request ---' 'Cyan'

    $branch = Get-CurrentBranch
    if ($branch -eq 'main') {
        Write-Host ''
        Write-Color 'ERROR: You are on the main branch!' 'Red'
        Write-Host ''
        Write-Color 'In this course, you must NEVER push directly to main.' 'Red'
        Write-Color 'Use option 1 to create a feature branch first.' 'Red'
        return
    }
    if ($branch -like 'release/*') {
        Write-Color ("Warning: you are on a release branch ({0}). Continuing..." -f $branch) 'Yellow'
    }

    Write-Host ''
    Write-Color '[Step 1/4] Checking for unpushed commits...' 'Cyan'

    # Check if remote branch exists
    $remoteCheck = Invoke-Git @('ls-remote', '--heads', 'origin', $branch)
    $remoteRef = if ($remoteCheck.ExitCode -eq 0 -and ($remoteCheck.Output | Out-String).Trim()) { "origin/$branch" } else { 'origin/main' }
    $r = Invoke-Git @('log', "$remoteRef..HEAD", '--oneline')
    $commits = @(($r.Output | Out-String) -split "`r?`n" | Where-Object { $_.Length -gt 0 })
    if ($commits.Count -eq 0) {
        Write-Color 'No new commits to push. Use option 2 to commit first.' 'Yellow'
        return
    }
    Write-Host ("  {0} commit(s) to push" -f $commits.Count)

    Write-Host ''
    Write-Color '[Step 2/4] Build verification' 'Cyan'
    Write-Host ''
    Write-Color "It's recommended to run 'mvn clean verify' before pushing." 'White'
    Write-Host 'Run build now? (y/n/skip) ' -NoNewline -ForegroundColor White
    $ans = (Read-Host).Trim().ToLower()
    if ($ans -eq 'y' -or $ans -eq 'yes') {
        if (-not (Test-Command 'mvn')) {
            Write-Color 'mvn not available; skipping build.' 'Yellow'
        } else {
            & mvn clean verify
            if ($LASTEXITCODE -ne 0) {
                Write-Color 'Build failed.' 'Red'
                if (-not (Read-YesNo 'Push anyway?')) { return }
            }
        }
    }

    Write-Host ''
    Write-Color '[Step 3/4] Pushing to remote...' 'Cyan'
    $r = Invoke-Git @('push', '-u', 'origin', $branch)
    Write-Host ($r.Output | Out-String)
    if ($r.ExitCode -ne 0) {
        Write-Color 'Push failed.' 'Red'
        return
    }

    Write-Host ''
    Write-Color '[Step 4/4] Creating Pull Request...' 'Cyan'

    $r = Invoke-Gh @('pr', 'list', '--head', $branch, '--json', 'number,url')
    if ($r.ExitCode -eq 0) {
        $existing = @()
        try { $existing = ($r.Output | Out-String).Trim() | ConvertFrom-Json } catch {}
        if ($existing -and $existing.Count -gt 0) {
            Write-Color ("A PR already exists for this branch: {0}" -f $existing[0].url) 'Yellow'
            return
        }
    }

    # Detect issue number
    $issueNum = $null
    $bm = [regex]::Match($branch, '(?:US|issue)-(\d+)', 'IgnoreCase')
    if ($bm.Success) { $issueNum = [int]$bm.Groups[1].Value }
    if (-not $issueNum) {
        $logR = Invoke-Git @('log', "$remoteRef..HEAD", '--format=%s')
        $logTxt = ($logR.Output | Out-String)
        $im = [regex]::Match($logTxt, '#(\d+)')
        if ($im.Success) { $issueNum = [int]$im.Groups[1].Value }
    }

    # Suggest title
    $suggested = $branch
    $sm = [regex]::Match($branch, '^feature/US-(\d+)-(.+)$', 'IgnoreCase')
    if ($sm.Success) {
        $titlePart = ($sm.Groups[2].Value -replace '-', ' ')
        $titlePart = (Get-Culture).TextInfo.ToTitleCase($titlePart)
        $suggested = "Implement US-$($sm.Groups[1].Value): $titlePart"
    }

    Write-Host ("PR title [{0}]: " -f $suggested) -NoNewline -ForegroundColor White
    $titleInput = Read-Host
    if ([string]::IsNullOrWhiteSpace($titleInput)) { $titleInput = $suggested }

    $closesLine = if ($issueNum) { "Closes #$issueNum" } else { "Closes #" }
    $body = @"
## Summary

$closesLine

## Changes
-

## Checklist
- [ ] Code compiles without errors
- [ ] Unit tests pass
- [ ] Issue referenced in commits
- [ ] Code reviewed by teammate
"@

    if (Read-YesNo 'Edit PR body in editor?') {
        $tmp = [System.IO.Path]::GetTempFileName() + '.md'
        Set-Content -Path $tmp -Value $body -Encoding UTF8
        $editor = if ($env:EDITOR) { $env:EDITOR } else { 'notepad.exe' }
        & $editor $tmp | Out-Null
        $body = Get-Content -Path $tmp -Raw
        Remove-Item $tmp -ErrorAction SilentlyContinue
    }

    $r = Invoke-Gh @('pr', 'create', '--base', 'main', '--title', $titleInput, '--body', $body)
    Write-Host ($r.Output | Out-String)
    if ($r.ExitCode -ne 0) {
        Write-Color 'Failed to create PR.' 'Red'
        return
    }
    Write-Color 'Pull Request created successfully!' 'Green'
    Write-Host ''
    Write-Color 'Next steps:' 'Green'
    Write-Color '  1. Ask a teammate to review your PR' 'Green'
    Write-Color '  2. Check that CI passes (green checkmark)' 'Green'
    Write-Color '  3. Once approved, merge the PR on GitHub' 'Green'
}

# ---------------------------------------------------------------------------
# Option 4: Project status
# ---------------------------------------------------------------------------

function Invoke-Status {
    Write-Host ''
    Write-Color '--- Project Status ---' 'Cyan'
    Write-Host ''

    $branch = Get-CurrentBranch
    Write-Host ('Branch:      ') -NoNewline; Write-Color $branch 'Yellow'

    $r = Invoke-Git @('log', '-1', '--format=%ai - %s')
    Write-Host ('Last commit: ') -NoNewline; Write-Host (($r.Output | Out-String).Trim())

    $remoteCheck = Invoke-Git @('ls-remote', '--heads', 'origin', $branch)
    if ($remoteCheck.ExitCode -eq 0 -and ($remoteCheck.Output | Out-String).Trim()) {
        $ahead = Invoke-Git @('rev-list', '--count', "origin/$branch..HEAD")
        $behind = Invoke-Git @('rev-list', '--count', "HEAD..origin/$branch")
        $a = ($ahead.Output | Out-String).Trim()
        $b = ($behind.Output | Out-String).Trim()
        Write-Host ('Remote:      ') -NoNewline
        Write-Host ("$a ahead, $b behind")
    } else {
        Write-Host ('Remote:      ') -NoNewline
        Write-Color 'not pushed' 'Yellow'
    }

    Write-Host ''
    Write-Color '--- Uncommitted Changes ---' 'Cyan'
    $st = Invoke-Git @('status', '--short')
    $stLines = @(($st.Output | Out-String) -split "`r?`n" | Where-Object { $_.Length -gt 0 })
    if ($stLines.Count -eq 0) {
        Write-Color '  (clean)' 'Green'
    } else {
        foreach ($l in $stLines) { Write-Host ('  ' + $l) }
        Write-Host ("  {0} file(s) changed" -f $stLines.Count)
    }

    Write-Host ''
    Write-Color '--- Your Open Issues (assigned to you) ---' 'Cyan'
    $r = Invoke-Gh @('issue', 'list', '--assignee', '@me', '--state', 'open', '--json', 'number,title,state', '--limit', '10')
    if ($r.ExitCode -eq 0) {
        try {
            $issues = ($r.Output | Out-String).Trim() | ConvertFrom-Json
            if (-not $issues -or $issues.Count -eq 0) {
                Write-Color '  (none)' 'DarkGray'
            } else {
                foreach ($i in $issues) {
                    Write-Host ("  #{0,-4} {1,-50} {2}" -f $i.number, $i.title, $i.state)
                }
            }
        } catch {
            Write-Color '  (could not parse)' 'Yellow'
        }
    } else {
        Write-Color '  (gh failed)' 'Yellow'
    }

    Write-Host ''
    Write-Color '--- Your Open Pull Requests ---' 'Cyan'
    $r = Invoke-Gh @('pr', 'list', '--author', '@me', '--state', 'open', '--json', 'number,title,state,statusCheckRollup')
    if ($r.ExitCode -eq 0) {
        try {
            $prs = ($r.Output | Out-String).Trim() | ConvertFrom-Json
            if (-not $prs -or $prs.Count -eq 0) {
                Write-Color '  (none)' 'DarkGray'
            } else {
                foreach ($p in $prs) {
                    $ci = ''
                    if ($p.statusCheckRollup) {
                        $failed = @($p.statusCheckRollup | Where-Object { $_.conclusion -eq 'FAILURE' })
                        if ($failed.Count -gt 0) { $ci = 'CI failing' } else { $ci = 'CI passing' }
                    }
                    Write-Host ("  #{0,-4} {1,-40} {2}  {3}" -f $p.number, $p.title, $p.state, $ci)
                }
            }
        } catch {
            Write-Color '  (could not parse)' 'Yellow'
        }
    }

    Write-Host ''
    Write-Color '--- Recent CI Status ---' 'Cyan'
    $r = Invoke-Gh @('run', 'list', '--limit', '1', '--json', 'status,conclusion,name,createdAt')
    if ($r.ExitCode -eq 0) {
        try {
            $runs = ($r.Output | Out-String).Trim() | ConvertFrom-Json
            if (-not $runs -or $runs.Count -eq 0) {
                Write-Color '  (no runs)' 'DarkGray'
            } else {
                $last = $runs[0]
                $col = 'Yellow'
                if ($last.conclusion -eq 'success') { $col = 'Green' }
                elseif ($last.conclusion -eq 'failure') { $col = 'Red' }
                Write-Host ('  Last workflow run: ') -NoNewline
                Write-Color ("{0} ({1}) - {2}" -f $last.conclusion, $last.status, $last.createdAt) $col
            }
        } catch {
            Write-Color '  (could not parse)' 'Yellow'
        }
    }
}

# ---------------------------------------------------------------------------
# Option 5: Create release tag
# ---------------------------------------------------------------------------

function Invoke-ReleaseTag {
    Write-Host ''
    Write-Color '--- Create Release Tag ---' 'Cyan'

    $branch = Get-CurrentBranch
    if ($branch -ne 'main') {
        Write-Color 'Switch to main first. Run: git checkout main' 'Red'
        return
    }

    $r = Invoke-Git @('pull', 'origin', 'main')
    Write-Host ($r.Output | Out-String)
    if ($r.ExitCode -ne 0) {
        Write-Color 'git pull failed.' 'Red'
        return
    }

    Write-Host ''
    Write-Color 'Available releases: R1, R2, R3, Final' 'White'
    Write-Host 'Enter release name (e.g., R2): ' -NoNewline -ForegroundColor White
    $rel = (Read-Host).Trim()
    $relUpper = $rel.ToUpper()
    if ($relUpper -eq 'FINAL') { $relUpper = 'Final' }
    if ($relUpper -notin @('R1', 'R2', 'R3', 'Final')) {
        Write-Color 'Invalid release name. Must be one of: R1, R2, R3, Final' 'Red'
        return
    }

    $tagCheck = Invoke-Git @('tag', '-l', $relUpper)
    if (($tagCheck.Output | Out-String).Trim()) {
        if (-not (Read-YesNo ("Tag {0} already exists. Overwrite?" -f $relUpper))) {
            return
        }
        $null = Invoke-Git @('tag', '-d', $relUpper)
        $null = Invoke-Git @('push', 'origin', "--delete", $relUpper)
    }

    Write-Host ''
    Write-Color ('Creating release branch and tag for ' + $relUpper + '...') 'Cyan'

    $relBranch = "release/$relUpper"
    $r = Invoke-Git @('checkout', '-b', $relBranch)
    Write-Host ($r.Output | Out-String)
    if ($r.ExitCode -ne 0) {
        Write-Color 'Failed to create release branch.' 'Red'
        return
    }
    $r = Invoke-Git @('push', 'origin', $relBranch)
    Write-Host ($r.Output | Out-String)

    $null = Invoke-Git @('checkout', 'main')
    $r = Invoke-Git @('tag', $relUpper)
    Write-Host ($r.Output | Out-String)
    $r = Invoke-Git @('push', 'origin', $relUpper)
    Write-Host ($r.Output | Out-String)

    if (Read-YesNo 'Create a GitHub Release?') {
        $repo = Get-RepoName
        $notes = "SE-Praktikum SS 2026 - Release $relUpper`n`nTeam: $repo"
        $r = Invoke-Gh @('release', 'create', $relUpper, '--title', "Release $relUpper", '--notes', $notes)
        Write-Host ($r.Output | Out-String)
        if ($r.ExitCode -eq 0) {
            Write-Color ("Release {0} created!" -f $relUpper) 'Green'
        } else {
            Write-Color 'Failed to create GitHub release.' 'Red'
        }
    }
}

# ---------------------------------------------------------------------------
# Option 6: Verify build
# ---------------------------------------------------------------------------

function Invoke-VerifyBuild {
    Write-Host ''
    Write-Color '--- Verify Build ---' 'Cyan'
    Write-Host ''
    Write-Color 'Running: mvn clean verify' 'White'
    Write-Color 'This may take a few minutes...' 'DarkGray'
    Write-Host ''

    if (-not (Test-Command 'mvn')) {
        Write-Color 'Maven is not installed or not in PATH.' 'Red'
        return
    }

    & mvn clean verify
    $exit = $LASTEXITCODE

    Write-Host ''
    if ($exit -eq 0) {
        Write-Color 'Build successful!' 'Green'
    } else {
        Write-Color 'Build failed!' 'Red'
        Write-Host ''
        Write-Color 'Check the output above for errors.' 'Yellow'
        Write-Color 'Common issues:' 'Yellow'
        Write-Color '  - Compilation errors: fix the code and try again' 'Yellow'
        Write-Color '  - Test failures: check failing test output' 'Yellow'
        Write-Color "  - Missing dependencies: run 'mvn clean install -U'" 'Yellow'
    }

    $jacoco = 'target/site/jacoco/index.html'
    if (Test-Path $jacoco) {
        Write-Host ''
        Write-Color ("Coverage Report: {0}" -f $jacoco) 'Cyan'
        if (Read-YesNo 'Open it?') {
            Start-Process $jacoco
        }
    }
}

# ---------------------------------------------------------------------------
# Main loop
# ---------------------------------------------------------------------------

Test-Prerequisites

while ($true) {
    Show-Header
    Write-Host 'Select an option (0-6): ' -NoNewline -ForegroundColor White
    $choice = (Read-Host).Trim()
    try {
        switch ($choice) {
            '1' { Invoke-StartUserStory; Pause-Menu }
            '2' { Invoke-Commit;         Pause-Menu }
            '3' { Invoke-PushPR;         Pause-Menu }
            '4' { Invoke-Status;         Pause-Menu }
            '5' { Invoke-ReleaseTag;     Pause-Menu }
            '6' { Invoke-VerifyBuild;    Pause-Menu }
            '0' {
                Write-Color 'Goodbye!' 'Cyan'
                exit 0
            }
            default {
                Write-Color 'Invalid choice.' 'Yellow'
                Start-Sleep -Seconds 1
            }
        }
    } catch {
        Write-Host ''
        Write-Color ("Unexpected error: {0}" -f $_.Exception.Message) 'Red'
        Pause-Menu
    }
}
