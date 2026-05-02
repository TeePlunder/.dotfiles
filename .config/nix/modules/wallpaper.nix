{ config, pkgs, ... }:
let
  wallpapers = [
    (pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/e7/wallhaven-e7kpl8.png";
      sha256 = "1gyfl8yh35c63zmlnsbj9mc8289jl4w794waq26wg6j44qgv1p12";
    })
    (pkgs.fetchurl {
      url = "https://images.alphacoders.com/134/1341120.png";
      sha256 = "0a6z1jc75snhd4fk66i9m9j47jan0gbwqvk1bcqq8ln120s7nf5m";
    })
  ];

  rotateScript = pkgs.writeShellScript "rotate-wallpaper" ''
    WALLPAPERS=(${builtins.concatStringsSep " " (map (w: ''"${w}"'') wallpapers)})
    INDEX=$(( $(date +%H) % ''${#WALLPAPERS[@]} ))
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
