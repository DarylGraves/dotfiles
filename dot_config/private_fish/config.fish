if status is-interactive
    # Commands to run in interactive sessions can go here
	fastfetch
	oh-my-posh init fish --config ~/.config/oh-my-posh/di4am0nd.omp.json | source
	set -gx EDITOR vim
	set -gx VISUAL vim
end

