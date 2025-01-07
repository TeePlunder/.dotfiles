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
            pkgs.neovim
            pkgs.zellij
            pkgs.lazygit
            pkgs.lazydocker
            pkgs.fzf
            pkgs.bat
            pkgs.raycast
            pkgs.obsidian
            pkgs.vscode
            pkgs.sketchybar
        ];

      homebrew = {
        enable = true;
        brews = [
          "fish"
          "mas" # to install apps from the app store through the cli
          "neovim"
          "lazygit"
          "lazydocker"
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
          "yarn"
          "bruno-cli"
          "node@20"
        ];
        casks = [
          "shottr"
          "alt-tab"
          "hiddenbar"
          "amethyst"
          "unnaturalscrollwheels"
          "zen-browser"
          "bruno"
          "trex"
          "ghostty"
          "raycast"
          "dbeaver-community"
          "arc"
          "docker"
          "spotify"
          "godspeed"
        ];
        masApps = {
            "Spark" = 1176895641;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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
        dock.persistent-apps = [
          "/Applications/Arc.app"
          "/Applications/Ghostty.app"
          # "${pkgs.alacritty}/Applications/Alacritty.app"
          "/Applications/Spark.app"
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

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
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
