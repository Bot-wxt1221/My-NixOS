{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.packages = with pkgs;[
    swaynotificationcenter
  ];
}
