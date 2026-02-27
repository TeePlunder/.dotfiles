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
      "fnm"
      "pnpm"
      "yarn"
      "oven-sh/bun/bun"
      "dark-notify"
      "azure-cli"
      "azcopy"
      "codex"
      "opencode"
      "go-task"
      "td"
      "lazysql"
      "sevenzip"
      "poppler"
      "resvg"
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
      "notion-calendar"
      "helium-browser"
      "claude-code"
      "font-symbols-only-nerd-font"
    ];
    masApps = {
      # "App Name" = Apple ID;
    };
    onActivation.cleanup = "zap";
    # onActivation.autoUpdate = true;
    # onActivation.upgrade = true;
  };
}
