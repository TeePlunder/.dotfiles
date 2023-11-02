#!/bin/bash

# ask which shell
echo -n "Which package manager do you want to use? => "
read -r pm

# PMC = Package Manager Command
case $pm in
  brew )
    PMC="$pm install" 
  ;;
  pacman)
    PMC="$pm -S"
    ;;
  *)
    echo "package manager not in install file"
    exit 1;
    ;;
esac

if [ $pm == "brew" ]; then
  # Install Brew
  echo "Installing Brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew analytics off

  ## Brew tabs
  brew tap homebrew/cask-fonts

  # Brew Casks
  echo "Installing Brew Casks..."
  brew install --cask spotify
  brew install --cask sf-symbols # for sketchybar
  brew install --cask unnaturalscrollwheels
fi

packageList=(
  neofetch
  lazygit
  lazydocker
  jq 
  sketchybar
  zsh-autosuggestions
  zsh-syntax-highlighting
  zellij
  koekeishiya/formulae/yabai
  koekeishiya/formulae/skhd
  exa
  starship
  bat
  fzf
  zoxide 
  entr
  gcc
  )

echo "Install all packages"
for package in "${packageList[@]}"; do
  $PM "$package"
done


echo "Installing nerd fonts..."
fonts_list=(
  font-3270-nerd-font
  font-fira-mono-nerd-font
  font-inconsolata-go-nerd-font
  font-inconsolata-lgc-nerd-font
  font-inconsolata-nerd-font
  font-monofur-nerd-font
  font-overpass-nerd-font
  font-ubuntu-mono-nerd-font
  font-agave-nerd-font
  font-arimo-nerd-font
  font-anonymice-nerd-font
  font-aurulent-sans-mono-nerd-font
  font-bigblue-terminal-nerd-font
  font-bitstream-vera-sans-mono-nerd-font
  font-blex-mono-nerd-font
  font-caskaydia-cove-nerd-font
  font-code-new-roman-nerd-font
  font-cousine-nerd-font
  font-daddy-time-mono-nerd-font
  font-dejavu-sans-mono-nerd-font
  font-droid-sans-mono-nerd-font
  font-fantasque-sans-mono-nerd-font
  font-fira-code-nerd-font
  font-go-mono-nerd-font
  font-gohufont-nerd-font
  font-hack-nerd-font # for sketchybar
  font-hasklug-nerd-font
  font-heavy-data-nerd-font
  font-hurmit-nerd-font
  font-im-writing-nerd-font
  font-iosevka-nerd-font
  font-jetbrains-mono-nerd-font
  font-lekton-nerd-font
  font-liberation-nerd-font
  font-meslo-lg-nerd-font
  font-monoid-nerd-font
  font-mononoki-nerd-font
  font-mplus-nerd-font
  font-noto-nerd-font
  font-open-dyslexic-nerd-font
  font-profont-nerd-font
  font-proggy-clean-tt-nerd-font
  font-roboto-mono-nerd-font
  font-sauce-code-pro-nerd-font
  font-shure-tech-mono-nerd-font
  font-space-mono-nerd-font
  font-terminess-ttf-nerd-font
  font-tinos-nerd-font
  font-ubuntu-nerd-font
  font-victor-mono-nerd-font
)

if [ "$pm" == "brew" ]; then
  brew tap homebrew/cask-fonts

  for font in "${fonts_list[@]}"; do
   brew install --cask "$font"
  done
fi


# macOS Settings
echo "Changing macOS defaults..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Finder AppleShowAllFiles -bool true
defaults write com.apple.finder "ShowPathbar" -bool "true"
killall Finder

# Copying and checking out configuration files
echo "Planting Configuration Files..."
[ ! -d "$HOME/.dotfiles" ] && git clone --bare git@github.com:TeePlunder/.dotfiles.git "$HOME"/.dotfiles
git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" checkout main

# Installing Fonts
echo "Installing Fonts"
git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
mv /tmp/SFMono_Nerd_Font/* "$HOME"/Library/Fonts
rm -rf /tmp/SFMono_Nerd_Font/

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o "$HOME"/Library/Fonts/sketchybar-app-font.ttf

# Start Services
echo "Starting Services (grant permissions)..."
brew services start sketchybar
yabai --start-service
skhd --start-service

# Install Colorls
echo "Install Colorls"
gem install colorls
