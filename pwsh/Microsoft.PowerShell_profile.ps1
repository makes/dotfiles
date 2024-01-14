$env:PAGER = "less"

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle InlineView #ListView
    Set-PSReadLineOption -EditMode Windows
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

Set-Alias vim nvim
Function Refresh-Path { $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") } 
Function notes { cd $home/codes/notes && nvim . && cd - }
Function zsh { sh --login }
