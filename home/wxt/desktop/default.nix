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
    ./waybar.nix
    ./swaync.nix
    #    ./clipboard.nix
  ];
}
