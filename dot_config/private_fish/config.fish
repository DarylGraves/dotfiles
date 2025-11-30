fish_add_path ~/.local/bin
oh-my-posh init fish --config ~/.config/oh-my-posh/slim.omp.json | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end
