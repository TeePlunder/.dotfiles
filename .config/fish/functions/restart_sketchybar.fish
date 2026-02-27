function restart_sketchybar --description "Restart nix-managed sketchybar service"
    launchctl kickstart -k gui/(id -u)/org.nixos.sketchybar
    and echo "sketchybar restarted"
end
