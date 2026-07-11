{ ... }: {
  # Sketchybar is installed and started through Homebrew because the nixpkgs
  # package currently fails to link on this macOS setup.
  programs.fish.enable = true;

  launchd.user.agents.theme-switcher.serviceConfig = {
    Label = "local.theme-switcher";
    ProgramArguments = [
      "/opt/homebrew/bin/dark-notify"
      "-c"
      "/Users/leonbergmann/.config/scripts/theme-watcher.sh"
    ];
    KeepAlive = true;
    RunAtLoad = true;
    StandardOutPath = "/tmp/theme-switcher.log";
    StandardErrorPath = "/tmp/theme-switcher.err";
  };
}
