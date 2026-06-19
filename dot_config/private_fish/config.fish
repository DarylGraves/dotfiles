if status is-interactive
    # Commands to run in interactive sessions can go here
	fastfetch
	oh-my-posh init fish --config ~/.config/oh-my-posh/di4am0nd.omp.json | source
	alias pomo='bash ~/.config/fish/scripts/pomodoro.sh'
	alias ls='ls -alh'
	set -gx EDITOR nvim
	set -gx VISUAL nvim
	set -gx KUBECONFIG ~/.kube/config


	if type -q kubectl
		kubectl completion fish | source
	end
end

function fish_user_key_bindings
    # This disables Ctrl+Z which I keep pushing in Nvim as an undo
    bind \cz 'commandline -f repaint'
end
