{ config, pkgs, ... }:
let
  wallpaperDir = "/Users/${config.system.primaryUser}/Pictures/BackgroundImages";

  rotateScript = pkgs.writeShellScript "rotate-wallpaper" ''
    WALLPAPER_DIR="${wallpaperDir}"
    WALLPAPERS=()

    while IFS= read -r -d "" file; do
      WALLPAPERS+=("$file")
    done < <(/usr/bin/find "$WALLPAPER_DIR" -maxdepth 1 -type f \( \
      -iname '*.jpg' -o \
      -iname '*.jpeg' -o \
      -iname '*.png' -o \
      -iname '*.heic' -o \
      -iname '*.webp' \
    \) -print0)

    if [ ''${#WALLPAPERS[@]} -eq 0 ]; then
      echo "No wallpapers found in $WALLPAPER_DIR" >&2
      exit 1
    fi

    INDEX=$(( ($(date +%s) / 3600) % ''${#WALLPAPERS[@]} ))
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"''${WALLPAPERS[$INDEX]}\""
  '';
in
{
  system.activationScripts.wallpaper.text = ''
    sudo -u ${config.system.primaryUser} ${rotateScript}
  '';

  launchd.user.agents.rotate-wallpaper = {
    command = "${rotateScript}";
    serviceConfig = {
      StartInterval = 3600;
    };
  };
}
