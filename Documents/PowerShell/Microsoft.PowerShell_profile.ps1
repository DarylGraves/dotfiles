$BaseRegistryPath = "HKCU:\Software\PowerShell\Profile\"

if (!(Test-Path -Path $BaseRegistryPath)) {
	New-Item -Path $BaseRegistryPath -Force
}

Set-PSReadLineOption -PredictionView List
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

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
$RegistryPath = "HKCU:\Software\PowerShell\Profile\InstalledModules"
$RequiredModules = @("CompletionPredictor", "Terminal-Icons", "ImportExcel", "PSWriteHTML", "PwshSpectreConsole")

# New install, create registry folder
if (!(Test-Path -Path $RegistryPath)) {
	New-Item -Path $RegistryPath -Force
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

function hosts {
	notepad "C:\Windows\System32\drivers\etc\hosts"
}

#################################################
# Work Specific - Seperate so it doesn't sync 
#################################################
$ProfilePath = Split-Path -Path $Profile -Parent
$WorkProfile = $ProfilePath + "\" + "WorkProfile.ps1"

if (Test-Path -Path $WorkProfile) {
	. $WorkProfile
}