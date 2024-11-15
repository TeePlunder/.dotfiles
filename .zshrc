# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  web-search)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
 alias zshconfig="mate ~/.zshrc"

# pnpm
export PNPM_HOME="/Users/leonbergmann/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
#
# alias for lazygit & lazydocker
alias lzd='lazydocker'
alias lg='lazygit'
alias c='clear'

# alias for neovim
alias n='nvim'

# alias for basic cmds
alias ls='exa'
alias la='exa -a'
alias ll='exa -alh'
alias tree='exa --tree'
alias ..="cd .."
alias cat='bat'

alias whatip="ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/leonbergmann/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/leonbergmann/Downloads/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/leonbergmann/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/leonbergmann/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(starship init zsh)"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

eval "$(zoxide init zsh)"

# eval $(brew --prefix)/opt/fzf/install
#
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# eval "$(op completion zsh)"; compdef _op op
source ~/.config/op/plugins.sh
export PATH=$PATH:$HOME/go/bin

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
