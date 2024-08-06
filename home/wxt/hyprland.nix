{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.file."~/.config/hypr/hyprland.conf".source = ./hyprland.conf;
}
