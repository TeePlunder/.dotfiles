{
  description = "TeePlunder nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, ... }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true; # allow to install unfree apps 

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
            pkgs.alacritty
            pkgs.mkalias
            pkgs.sketchybar
        ];

      homebrew = {
        enable = true;
        brews = [
          "fish"
          "mas" # to install apps from the app store through the cli
          "neovim"
          "bat"
          "zoxide"
          "ripgrep"
          "curl"
          "fzf"
          "cmake"
          "go"
          "gh"
          "openssh"
          "zellij"
          "go-task"
          "tldr"
          "fisher"
          "td"
          # "node@22"
          "yarn"
          "htop"
          "coreutils"
          "pnpm"
          # "mysql@8.0"
          "fnm"
          "azcopy"
          "entr"
          "derailed/k9s/k9s"
          "azure-cli"
          "kubectl"
          "lazygit"
          "lazydocker"
          "neovim"
          "zellij"
          "fzf"
          "bat"
        ];
        casks = [
          "shottr"
          "alt-tab"
          "hiddenbar"
          "amethyst"
          "unnaturalscrollwheels"
          "zen"
          "bruno"
          "trex"
          "raycast"
          "dbeaver-community"
          "docker-desktop"
          "spotify"
          "sf-symbols"
          "aldente"
          "zed"
          "ghostty"
          "appcleaner"
          "chatgpt"
          "visual-studio-code"
          "obsidian"
          "raycast"
          "thebrowsercompany-dia"
        ];
        onActivation.cleanup = "zap";
        # onActivation.autoUpdate = true;
        # onActivation.upgrade = true;
      };

      fonts.packages = [
        pkgs.nerd-fonts."jetbrains-mono"
      ];

      # Fixing Mac Spotlight to get the nix applications like alacritty 
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
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


      system.defaults = {
        dock.autohide = true;
        dock.autohide-delay = null;
        dock.persistent-apps = [
          "/Applications/Dia.app"
          "/Applications/Ghostty.app"
          "/Applications/Bruno.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
        ];
        finder.FXPreferredViewStyle = "clmv";
        finder.AppleShowAllExtensions = true;
        finder.ShowPathbar = true;
        finder.ShowStatusBar = true;
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
        trackpad.Clicking = true;
        trackpad.TrackpadThreeFingerDrag = true;
      };

      # Make sure nix-darwin manages Nix itself:
      nix.enable = true;  # manage the Nix installation + daemon
      # nix.package = pkgs.nix;

      services.sketchybar = {
        enable = true;
        package = pkgs.sketchybar;
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
      modules = [ 
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "leonbergmann";

              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
            };
          }
        ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."work".pkgs;
  };
}
