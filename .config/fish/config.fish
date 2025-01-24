if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

# Add Node@20's bin directory to PATH
set -gx PATH /opt/homebrew/opt/node@20/bin $PATH

# For compilers to find node@20 (if needed)
set -gx LDFLAGS "-L/opt/homebrew/opt/node@20/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/node@20/include"

set -Ux fish_user_paths /opt/homebrew/bin $HOME/go/bin $fish_user_paths

function psgrep
    pgrep -d ',' $argv | xargs -I _ ps -fp _
end

function topgrep
    htop -p (pgrep -d ',' $argv)
end

function pkillgrep
    pgrep $argv | xargs -I _ kill -9 _
end


function fzf_history
  history | fzf --height=40% --reverse --preview="echo {}" | read -l cmd
      if test -n "$cmd"
          eval $cmd
      end
end

alias fh=fzf_history
