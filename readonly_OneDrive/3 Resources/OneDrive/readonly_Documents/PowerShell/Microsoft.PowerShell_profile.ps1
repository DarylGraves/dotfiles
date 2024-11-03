Set-PoshPrompt -Theme slim
Set-PSReadLineOption -PredictionView List
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

#################################################
# Modules
#################################################
$RequiredModules = @("CompletionPredictor", "Terminal-Icons", "ImportExcel", "PSWriteHTML", "PwshSpectreConsole")

foreach ($Module in $RequiredModules) {
	$ModuleInstalled = Get-Module -ListAvailable -SkipEditionCheck -ErrorAction SilentlyContinue -Name $Module

	if ($null -eq $ModuleInstalled) {
		Install-Module -Name $Module -Scope CurrentUser -Force
	}

	Import-Module -Name $Module
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
