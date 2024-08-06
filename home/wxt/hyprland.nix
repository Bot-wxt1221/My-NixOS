{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  wayland.windowManager.hyprland.extraConfig = buildins.readFile "./hyprland.conf";
}
