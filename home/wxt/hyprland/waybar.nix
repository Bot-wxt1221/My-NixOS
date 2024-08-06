{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.packages = with pkgs;[
    waybar
  ];
}
