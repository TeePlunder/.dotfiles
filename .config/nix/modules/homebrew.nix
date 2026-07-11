{ ... }: {
  homebrew = {
    enable = true;
    taps = [
      "cormacrelf/tap"
    ];
    brews = [
      "fish"
      "fisher"
      "mas"
      "neovim"
      "zellij"
      "openssh"
      "dark-notify"
      "td"
      "lazysql"
      "sevenzip"
      "poppler"
      "resvg"
      "hashicorp/tap/terraform"
      "mise"
    ];
    casks = [
      "shottr"
      "alt-tab"
      "amethyst"
      "unnaturalscrollwheels"
      "zen"
      "bruno"
      "raycast"
      "dbeaver-community"
      "docker-desktop"
      "spotify"
      "sf-symbols"
      "aldente"
      "zed"
      "ghostty"
      "appcleaner"
      "obsidian"
      "notion-calendar"
      "helium-browser"
      "claude-code"
      "font-symbols-only-nerd-font"
      "codex"
    ];
    masApps = {
      # "App Name" = Apple ID;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
