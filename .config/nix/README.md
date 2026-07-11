# How to get applications

## To install everything

```fish
sudo nix run nix-darwin -- switch --flake .#private
```

## Recommended update workflow

```fish
nix flake update
brew update
sudo nix run nix-darwin -- switch --flake .#private
```

This keeps the Nix-managed parts and Homebrew in sync:

1. `nix flake update` updates the pinned flake inputs, including the Nix-provided Homebrew/nix-darwin tooling.
2. `brew update` updates Homebrew tap metadata, so Homebrew knows about the newest formulae and casks.
3. `sudo nix run nix-darwin -- switch --flake .#private` applies the system configuration and lets nix-darwin run the configured Homebrew bundle/upgrade step.

This is safer than letting Homebrew auto-update during every nix-darwin activation, because the Homebrew executable managed by Nix and the Homebrew cask/formula metadata are updated intentionally together.

## Update flake inputs only

```fish
nix flake update
```
