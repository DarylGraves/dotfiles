Set-PoshPrompt -Theme slim
Set-PSReadLineOption -PredictionView List
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

Import-Module -Name CompletionPredictor
Import-Module -Name Terminal-Icons

function vim {
	& "C:\Program Files\Vim\vim91\vim.exe" $args && echo "`e[5 q"
}

function vi {
	& "C:\Program Files\Vim\vim91\vim.exe" $args && echo "`e[5 q"
}

function hosts {
	notepad "C:\Windows\System32\drivers\etc\hosts"
}
