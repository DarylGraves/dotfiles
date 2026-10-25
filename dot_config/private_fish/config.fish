if status is-interactive
    # Commands to run in interactive sessions can go here
	fastfetch
	oh-my-posh init fish --config ~/.config/oh-my-posh/di4am0nd.omp.json | source
	alias pomo='bash ~/.config/fish/scripts/pomodoro.sh'
	alias ls='ls -alh'
	alias k='kubectl'
	alias v='nvim'
	set -gx EDITOR nvim
	set -gx VISUAL nvim
	set -gx KUBECONFIG ~/.kube/config

		# For nvim
	fish_add_path /opt/nvim/

	if type -q kubectl
		kubectl completion fish | source
	end
end

function fish_user_key_bindings
    # This disables Ctrl+Z which I keep pushing in Nvim as an undo
    bind \cz 'commandline -f repaint'
end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/home/daryl/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
