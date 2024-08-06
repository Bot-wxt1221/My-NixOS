{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.file.".config/hypr/wallpaper.png".source = ./nixos-wallpaper-catppuccin-latte.png;
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = ["${config.home.homeDirectory}/.config/hypr/wallpaper.png"];
    wallpaper = [",${config.home.homeDirectory}/.config/hypr/wallpaper.png"];
  };
  home.packages = with pkgs;[
    hyprpaper
  ];
}
