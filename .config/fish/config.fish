if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

set -Ux fish_user_paths $fish_user_paths $HOME/go/bin

function fzf_history
  history | fzf --height=40% --reverse --preview="echo {}" | read -l cmd
      if test -n "$cmd"
          eval $cmd
      end
end

alias fh=fzf_history
