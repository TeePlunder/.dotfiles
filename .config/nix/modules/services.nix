{ ... }: {
  # Sketchybar is installed and started through Homebrew because the nixpkgs
  # package currently fails to link on this macOS setup.
  programs.fish.enable = true;
}
