if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

set -Ux fish_user_paths /opt/homebrew/bin $HOME/go/bin $fish_user_paths

#set -gx NVM_DIR (brew --prefix nvm)

function psgrep
    pgrep -d ',' $argv | xargs -I _ ps -fp _
end

function topgrep
    htop -p (pgrep -d ',' $argv)
end

function pkillgrep
    pgrep $argv | xargs -I _ kill -9 _
end

