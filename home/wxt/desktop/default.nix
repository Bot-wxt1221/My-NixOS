{
  config,
  lib,
  pkgs,
  niri,
  ...
}:
{
  imports = [
    ./hyprpaper.nix
    ./swaylock.nix
    ./niri.nix
    ./waybar.nix
    ./swaync.nix
    #    ./clipboard.nix
  ];
}
