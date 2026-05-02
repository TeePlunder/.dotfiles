{ ... }:
{
  system.defaults = {
    dock.autohide = true;
    dock.autohide-delay = null;
    dock.mru-spaces = false;
    dock.minimize-to-application = true;
    dock.show-recents = false;
    dock.persistent-apps = [
      "/Applications/Helium.app"
      "/Applications/Ghostty.app"
      "/Applications/Bruno.app"
      "/Applications/DBeaver.app"
      "/Applications/Notion Calendar.app"
      "/Applications/Obsidian.app"
    ];
    # disable hot corners
    dock.wvous-tl-corner = 1;
    dock.wvous-tr-corner = 1;
    dock.wvous-bl-corner = 1;
    dock.wvous-br-corner = 1;

    finder.FXPreferredViewStyle = "clmv";
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    finder.FXEnableExtensionChangeWarning = false;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;

    loginwindow.GuestEnabled = false;

    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.InitialKeyRepeat = 15;

    screencapture.location = "~/Screenshots";
    screencapture.type = "png";

    menuExtraClock.ShowSeconds = true;

    trackpad.Clicking = true;
    trackpad.TrackpadThreeFingerDrag = true;
  };

  system.primaryUser = "leonbergmann";

  security.pam.services.sudo_local.touchIdAuth = true;
}
