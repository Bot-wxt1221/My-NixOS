{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  wayland.windowManager.hyprland.extraConfig = "exec";
}
