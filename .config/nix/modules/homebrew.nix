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
      "zellij"
      "openssh"
      "dark-notify"
      "azure-cli"
      "azcopy"
      "td"
      "lazysql"
      "sevenzip"
      "poppler"
      "resvg"
      "hashicorp/tap/terraform"
      "mise"
      "exercism"
      "wget"
      "mole"
    ];
    casks = [
      "shottr"
      "amethyst"
      "bruno"
      "raycast"
      "dbeaver-community"
      "docker-desktop"
      "spotify"
      "sf-symbols"
      "aldente"
      "zed"
      "ghostty"
      "obsidian"
      "notion-calendar"
      "helium-browser"
      "claude-code@latest"
      "lens"
      "font-symbols-only-nerd-font"
      "microsoft-teams"
      "fluidvoice"
      "obs"
    ];
    masApps = {
      # "App Name" = Apple ID;
    };
    onActivation.cleanup = "zap";
    # onActivation.autoUpdate = true;
    # onActivation.upgrade = true;
  };
}
