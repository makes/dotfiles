# Powershell

```powershell
New-Item -Path $PROFILE -ItemType SymbolicLink -Value $(Resolve-Path .\Microsoft.PowerShell_profile.ps1)
```
