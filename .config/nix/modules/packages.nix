{ pkgs, config, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    alacritty
    mkalias
    sketchybar
    bat
    ripgrep
    fd
    fzf
    zoxide
    jq
    htop
    curl
    coreutils
    yazi
    lazygit
    lazydocker
    ffmpeg
    imagemagick
    go
    cmake
    kubectl
    gh
    tldr
    stow
    entr
    k9s
    pipx
    stylua
  ];

  fonts.packages = [
    pkgs.nerd-fonts."jetbrains-mono"
  ];

  # alias nix apps into /Applications for Spotlight
  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = ["/Applications"];
    };
  in
    pkgs.lib.mkForce ''
    echo "setting up /Applications..." >&2
    rm -rf /Applications/Nix\ Apps
    mkdir -p /Applications/Nix\ Apps
    find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
    while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
    done
        '';
}
