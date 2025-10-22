# Sync Claude Code Agents & Commands to All Projects
# Run this after updating any agent or command in this repo

$MASTER_REPO = "C:\Users\mrdre\CodeProjects\AI-Agents-and-Prompts"
$PROJECTS_ROOT = "C:\Users\mrdre\CodeProjects"

Write-Host "Syncing Claude Code configurations from master repo..." -ForegroundColor Cyan
Write-Host "Master: $MASTER_REPO" -ForegroundColor Gray
Write-Host ""

# Find all .claude directories (excluding the master repo itself)
$claudeDirs = Get-ChildItem -Path $PROJECTS_ROOT -Recurse -Directory -Filter ".claude" -ErrorAction SilentlyContinue |
              Where-Object { $_.FullName -notlike "*AI-Agents-and-Prompts*" }

if ($claudeDirs.Count -eq 0) {
    Write-Host "No Claude Code projects found in $PROJECTS_ROOT" -ForegroundColor Yellow
    exit
}

Write-Host "Found $($claudeDirs.Count) Claude Code projects" -ForegroundColor Green
Write-Host ""

$syncedProjects = 0
$errors = @()

foreach ($claudeDir in $claudeDirs) {
    $projectName = $claudeDir.Parent.Name

    try {
        # Sync Commands
        $commandsDir = Join-Path $claudeDir.FullName "commands"
        if (!(Test-Path $commandsDir)) {
            New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null
        }

        $commandFiles = Get-ChildItem -Path "$MASTER_REPO\commands\*.md" -File
        foreach ($file in $commandFiles) {
            Copy-Item -Path $file.FullName -Destination $commandsDir -Force
        }

        # Sync Agents
        $agentsDir = Join-Path $claudeDir.FullName "agents"
        if (!(Test-Path $agentsDir)) {
            New-Item -ItemType Directory -Path $agentsDir -Force | Out-Null
        }

        $agentFiles = Get-ChildItem -Path "$MASTER_REPO\agents\*.md" -File
        foreach ($file in $agentFiles) {
            Copy-Item -Path $file.FullName -Destination $agentsDir -Force
        }

        Write-Host "  OK $projectName" -ForegroundColor Green
        Write-Host "    Commands: $($commandFiles.Count) | Agents: $($agentFiles.Count)" -ForegroundColor Gray

        $syncedProjects++
    }
    catch {
        $errors += "  ERROR $projectName - $($_.Exception.Message)"
        Write-Host "  ERROR $projectName" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Sync Complete!" -ForegroundColor Green
Write-Host "   Synced: $syncedProjects projects" -ForegroundColor Gray
Write-Host "   Commands: $((Get-ChildItem "$MASTER_REPO\commands\*.md").Count) files" -ForegroundColor Gray
Write-Host "   Agents: $((Get-ChildItem "$MASTER_REPO\agents\*.md").Count) files" -ForegroundColor Gray

if ($errors.Count -gt 0) {
    Write-Host ""
    Write-Host "Errors:" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host $_ -ForegroundColor Red }
}

Write-Host ""
Write-Host "Tip: Run this script after updating agents or commands" -ForegroundColor Yellow
