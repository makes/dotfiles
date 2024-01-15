$PROFILEPATH = Split-Path -Parent $PROFILE
$WORKSTATIONPROFILE = Join-Path $PROFILEPATH "workstation.ps1"

$env:EDITOR = "nvim"
$env:PAGER = "less"

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle InlineView #ListView
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -Colors @{ InlinePrediction = '#2F7004' } # green
}

Get-ChildItem "$PROFILE\..\Completions\" | ForEach-Object {
    . $_.FullName
}

if (Get-Command Import-VisualStudioVars) {
    Import-VisualStudioVars
} else {
    Write-Host "PowerShell Community Extensions missing. Installation:"
    Write-Host "Install-Module -Name Pscx -AllowPrerelease"
    Write-Host "Install-Module -Name VSSetup"
}

$PSStyle.FileInfo.Directory = $PSStyle.Foreground.BrightBlue
$PSStyle.FileInfo.Extension['.xz'] = $PSStyle.FileInfo.Extension['.tgz']
$PSStyle.FileInfo.Extension['.zst'] = $PSStyle.FileInfo.Extension['.tgz']

if (Get-Alias -Name 'r' -ErrorAction SilentlyContinue) {
    Remove-Item -Path Alias:r
}

Set-Alias vim nvim
Function nvimc { nvim $env:LOCALAPPDATA\nvim\lua }

Set-Alias docker podman
Function gitbash { sh --login }
Function notes { cd $home/codes/notes && nvim . && cd - }
Function updateconda { conda update -n base -c defaults conda }
Function gcs([string]$param) { gh copilot suggest $param }
Function gce([string]$param) { gh copilot explain $param }
Function gs { git status }

Function Refresh-Path { $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") } 

# load workstation-specific config
if (Test-Path -Path $WORKSTATIONPROFILE) { . $WORKSTATIONPROFILE }
