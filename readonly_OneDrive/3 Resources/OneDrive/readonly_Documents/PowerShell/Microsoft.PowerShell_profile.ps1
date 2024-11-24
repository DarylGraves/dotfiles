Set-PSReadLineOption -PredictionView List
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

#################################################
# Creating base registry folder
#################################################
$BaseRegistryPath = "HKCU:\Software\PowerShell\Profile\"

if (!(Test-Path -Path $BaseRegistryPath)) {
	New-Item -Path $BaseRegistryPath -Force
}

#################################################
# Posh Prompt
#################################################
try {
	Set-PoshPrompt -Theme slim
}
catch {
	Write-Error "OhMyPosh not installed. Run the below and restart the terminal:`n`twinget install JanDeDobbeleer.OhMyPosh -s winget"
}

#################################################
# Confirm Release It is installed
#################################################
$InstalledAppsReg = $BaseRegistryPath + "InstalledApps"

if (!(Test-Path -Path $InstalledAppsReg)) {
	New-Item -Path $InstalledAppsReg -Force | Out-Null
}

$ReleaseItInstalled = (Get-ItemProperty -Path $InstalledAppsReg).ReleaseIt 

if ($ReleaseItInstalled -ne 1) {
	try {
		$Count = (npm ls -gl | Select-String release-it).count

		if ($Count -gt 0) {
			Set-ItemProperty -Path $InstalledAppsReg -Name "ReleaseIt" -Value 1
		}
	}
	catch {
		Write-Error "Release-It and Auto-ChangeLog not installed. First install NPM if you haven't already and then run the the two lines below before restarting the terminal:`n`tnpm install -g release-it`n`tnpm install -g auto-changelog"
	}
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
