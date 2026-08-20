{ ... }: {
  homebrew = {
    enable = true;
    taps = [
      "cormacrelf/tap"
      "felixkratz/formulae"
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
      {
        name = "felixkratz/formulae/sketchybar";
        start_service = true;
      }
      "wget"
      "exercism"
    ];
    casks = [
      "shottr"
      "alt-tab"
      "amethyst"
      "unnaturalscrollwheels"
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
      "fluidvoice"
      "wifiman"
      "openlogi"
    ];
    masApps = {
      "AusweisApp" = 948660805;
      "keymapp" = 6472865291;
      "Microsoft Word" = 462054704;
      "MyWhoosh Indoor Cycling App" = 1498889644;
      "Pages" = 409201541;
      "Phiewer (lite)" = 1226444549;
      "Print to PDF" = 1639234272;
      "QuickShade" = 931571202;
      "Unzip - RAR ZIP 7Z Unarchiver" = 1537056818;
      "WhatsApp" = 310633997;
      "xFormula" = 1503622988;
    };
    global.autoUpdate = false;

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = false;
    onActivation.upgrade = true;
    onActivation.extraEnv = {
      HOMEBREW_NO_ANALYTICS = "1";
      HOMEBREW_NO_ENV_HINTS = "1";
    };
  };
}
