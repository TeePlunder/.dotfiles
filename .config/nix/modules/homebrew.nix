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
    ];
    masApps = {
      "AusweisApp" = 948660805;
      "Hidden Bar" = 1452453066;
      "keymapp" = 6472865291;
      "Microsoft Word" = 462054704;
      "MyWhoosh Indoor Cycling App" = 1498889644;
      "Pages" = 409201541;
      "Phiewer (lite)" = 1226444549;
      "Pixea" = 1507782672;
      "Prime Video" = 545519333;
      "Print to PDF" = 1639234272;
      "QR Capture" = 1369524274;
      "QuickShade" = 931571202;
      "Unzip - RAR ZIP 7Z Unarchiver" = 1537056818;
      "VoiceAI" = 6444030605;
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
