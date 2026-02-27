{
  description = "TeePlunder nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, ... }: {
    darwinConfigurations."private" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/packages.nix
        ./modules/homebrew.nix
        ./modules/system.nix
        ./modules/services.nix
        nix-homebrew.darwinModules.nix-homebrew
        ({ config, ... }: {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = config.system.primaryUser;
            autoMigrate = true;
          };
        })
        {
          nix.enable = true;
          nix.gc = {
            automatic = true;
            interval = { Weekday = 7; Hour = 3; Minute = 0; };
            options = "--delete-older-than 30d";
          };
          nix.optimise.automatic = true;
          nix.settings = {
            experimental-features = "nix-command flakes";
            substituters = [
              "https://cache.nixos.org"
              "https://nix-community.cachix.org"
            ];
            trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];
          };

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
          nixpkgs.hostPlatform = "aarch64-darwin";
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."private".pkgs;
  };
}
