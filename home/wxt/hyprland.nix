{ config, lib, pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
  ];
  home.file.".config/hypr/hyprland.conf".text = ''
    
  '';
}
