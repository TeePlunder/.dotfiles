if status is-interactive
    set -gx EDITOR nvim
    set -gx VISUAL nvim
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

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/leonbergmann/.lmstudio/bin
# End of LM Studio CLI section

fish_add_path (npm config get prefix)/bin
fish_add_path ~/.local/bin
alias db="sqlit"
