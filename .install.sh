# Install Brew
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

## Brew tabs
brew tap homebrew/cask-fonts

# Brew Formulare
echo "Installing Brew Formulare..."
brew install neofetch
brew install lazygit
brew install lazydocker
brew install jq
brew install sketchybar
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Brew Casks
echo "Installing Brew Casks..."
brew install --cask spotify
brew install --cask font-hack-nerd-font # for sketchybar
brew install --cask sf-symbols          # for sketchybar
brew install --cask font-jetbrains-mono-nerd-font

# macOS Settings
echo "Changing macOS defaults..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Copying and checking out configuration files
echo "Planting Configuration Files..."
[ ! -d "$HOME/.dotfiles" ] && git clone --bare git@github.com:TeePlunder/.dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout main

# Installing Fonts
echo "Installing Fonts"
git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
mv /tmp/SFMono_Nerd_Font/* $HOME/Library/Fonts
rm -rf /tmp/SFMono_Nerd_Font/

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# Start Services
echo "Starting Services (grant permissions)..."
brew services start sketchybar

# Install Colorls
echo "Install Colorls"
gem install colorls
