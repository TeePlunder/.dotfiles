{
  description = "Multi-machine nix-darwin system flake with shared and host-specific configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, ... }: let

    # Base configuration common to all machines
    baseConfiguration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = [
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
      ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
          "bruno-cli"
        ];
        casks = [
          # "hammerspoon"
          # "iina"
          # "the-unarchiver"
          "Spark"
          "shottr"
          "alt-tab"
          "hiddenbar"
          "amethyst"
          "unnaturalscrollwheels"
          "zen-browser"
          "bruno"
        ];
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      # Fixing Mac Spotlight to get nix applications like Alacritty
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in pkgs.lib.mkForce ''
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
          "/Applications/Zen Browser.app"
          "${pkgs.alacritty}/Applications/Alacritty.app"
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
      };

      services.nix-daemon.enable = true;

      nix.settings.experimental-features = "nix-command flakes";

      programs.fish.enable = true;

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };

    # Configuration overrides for the private machine
    privateConfiguration = { pkgs, config, ... }: {
      # Here you could add packages or settings unique to your private machine.
      # For example, private-only packages:
      masApps = {
        "Phiewer" = 1226444549;
      };
      environment.systemPackages = config.environment.systemPackages ++ [
        pkgs.htop
        pkgs.pass
      ];
    };

    # Configuration overrides for the work machine
    workConfiguration = { pkgs, config, ... }: {
      # Add or override packages for the work environment
      environment.systemPackages = config.environment.systemPackages ++ [
        pkgs.azure-cli
      ];

      # # Possibly different defaults for the dock or finder for work
      # system.defaults = pkgs.lib.mkMerge [
      #   config.system.defaults
      #   {
      #     dock.persistent-apps = [
      #       # maybe you need different apps in your dock for work
      #       "/Applications/Visual Studio Code.app"
      #       "${pkgs.obsidian}/Applications/Obsidian.app"
      #     ];
      #   }
      # ];
    };

    nixHomebrewModuleForUser = { user }:
          [
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true;
                user = user;
                autoMigrate = true;
              };
            }
          ];

  in {
    # Private configuration
    darwinConfigurations."private" = nix-darwin.lib.darwinSystem {
      modules = [
        baseConfiguration
        privateConfiguration
        (nixHomebrewModuleForUser { user = "leonbergmann"; })
      ];
    };

    # Work configuration
    darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
      modules = [
        baseConfiguration
        workConfiguration
        (nixHomebrewModuleForUser { user = "TODO"; })
      ];
    };

    # Expose the package sets for convenience
    darwinPackages = self.darwinConfigurations."private".pkgs;
  };
}
