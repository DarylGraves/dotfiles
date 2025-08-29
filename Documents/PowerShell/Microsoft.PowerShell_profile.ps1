$BaseRegistryPath = "HKCU:\Software\PowerShell\Profile\"

if (!(Test-Path -Path $BaseRegistryPath)) {
	New-Item -Path $BaseRegistryPath -Force | Out-Null
}

Set-PSReadLineOption -PredictionView List
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

# New install, create registry folder
if (!(Test-Path -Path $BaseRegistryPath)) {
	New-Item -Path $BaseRegistryPath -Force | Out-Null
}

#################################################
# New Machine - Install Software if personal
#################################################
$NewMachine = (Get-ItemProperty -Path $BaseRegistryPath).NewMachine

if ($Null -eq $NewMachine) {
	New-ItemProperty -Path $BaseRegistryPath -Name "NewMachine" -PropertyType Binary -Value 1 | Out-Null
	$NewMachine = (Get-ItemProperty -Path $BaseRegistryPath).NewMachine
}

if ($NewMachine -eq 1) {
	Write-Host "New Machine!" -ForegroundColor Yellow

	$isValid = $false

	do {
		$Answer = Read-Host "Personal or Work Computer? (P for Personal, W for Work)"
		if ($Answer[0] -eq "p" -or $Answer[0] -eq "w") {
			$isValid = $true
		}
	} while ($isValid -eq $false)

	if ($Answer[0] -eq "p") {
		Write-Host "Personal selected. Installing software via Winget" -ForegroundColor Magenta
		& winget import "$ENV:USERPROFILE\.config\FirstTimeSetup\1.Winget-NoDependancies.json"
		Write-Host "Personal selected. Installing second set of software from Winget" -ForegroundColor Magenta
		& winget import "$ENV:USERPROFILE\.config\FirstTimeSetup\2.Winget-HasDependancies.json"
	}

	Set-ItemProperty -Path $BaseRegistryPath -Name "NewMachine" -Value 0 | Out-Null
}

#################################################
# Posh Prompt
#################################################
try {
	$env:Path += ";C:\Users\$Env:USERNAME\AppData\Local\Programs\oh-my-posh\bin"
	oh-my-posh init pwsh --config "C:\Users\$Env:USERNAME\AppData\Local\Programs\oh-my-posh\themes\slim.omp.json" | Invoke-Expression
}
catch {
	Write-Error "OhMyPosh not installed. Run the below and restart the terminal:`n`twinget install JanDeDobbeleer.OhMyPosh -s winget"
}

#################################################
# Modules
#################################################
$RegistryPath = $BaseRegistryPath + "InstalledModules"
$RequiredModules = @("Az", "CompletionPredictor", "Terminal-Icons", "ImportExcel", "PSWriteHTML", "PwshSpectreConsole", "Terminal-Icons", "PSFzf")

if (!(Test-Path -Path $RegistryPath)) {
	New-Item -Path $RegistryPath -Force | Out-Null
}

foreach ($Module in $RequiredModules) {
	# Create value
	$ModuleInstalled = (Get-ItemProperty -Path "$RegistryPath").$Module
	if ($Null -eq $ModuleInstalled) {
		New-ItemProperty -Path $RegistryPath -Name $Module -PropertyType Binary -Value 0 | Out-Null
	}

	if ($ModuleInstalled -eq 1) {
		continue 
	}

	try {
		Install-Module -Name $Module -Scope CurrentUser -Force -ErrorAction Stop
		Set-ItemProperty -Path $RegistryPath -Name $Module -Value 1 | Out-Null
	}
	catch {
		Write-Error "Unable to install $Module"
	}
}

#################################################
# Fzf
#################################################

# winget install fzf
# Shortcuts: ctrl+t, ctrl+r, alt+c and alt+a
if((Get-Command "fzf" -ErrorAction SilentlyContinue ).count -gt 0)
{
	Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
}

#################################################
# Aliases
#################################################
Set-Alias -Name "adu" -Value "Get-AdUser"
Set-Alias -Name "adg" -Value "Get-AdGroup"
Set-Alias -Name "adgm" -Value "Get-AdGroupMember"
Set-Alias -Name "adp" -Value "Get-AdPrincipalGroupMembership"

#################################################
# Functions
#################################################
function vim {
	& "C:\Program Files\Vim\vim91\vim.exe" $args && echo "`e[5 q"
}

function vi {
	& "C:\Program Files\Vim\vim91\vim.exe" $args && echo "`e[5 q"
}

function nvim {
	& "C:\Program Files\Neovim\bin\nvim.exe" $args
}

function hosts {
	notepad "C:\Windows\System32\drivers\etc\hosts"
}

#################################################
# Calling any Modules
#################################################
Import-Module Terminal-Icons

#################################################
# Work Specific - Seperate so it doesn't sync 
#################################################
$ProfilePath = Split-Path -Path $Profile -Parent
$WorkProfile = $ProfilePath + "\\" + "WorkProfile.ps1"

if (Test-Path -Path $WorkProfile) {
	. $WorkProfile
}
