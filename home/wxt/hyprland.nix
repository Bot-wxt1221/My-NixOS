{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/wallpaper.png".source = ./nixos-wallpaper-catppuccin-latte.png;
  home.file.".config/hypr/hyprpaper.conf".text = builtins.readFile "./hyprpaper.conf";
}
