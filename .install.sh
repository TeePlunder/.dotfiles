# Install Brew
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

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
brew install --cask font-hack-nerd-font

# macOS Settings
echo "Changing macOS defaults..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Finder AppleShowAllFiles -bool true

