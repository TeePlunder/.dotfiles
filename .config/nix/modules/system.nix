{ pkgs, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/e7/wallhaven-e7kpl8.png";
    sha256 = "1gyfl8yh35c63zmlnsbj9mc8289jl4w794waq26wg6j44qgv1p12";
  };
in
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

  system.activationScripts.wallpaper.text = ''
    sudo -u leonbergmann osascript -e 'tell application "Finder" to set desktop picture to POSIX file "${wallpaper}"'
  '';
}
