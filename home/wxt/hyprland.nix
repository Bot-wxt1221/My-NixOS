{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  wayland.windowManager.hyprland.extraConfig = builtins.readFile "./hyprland.conf";
}
