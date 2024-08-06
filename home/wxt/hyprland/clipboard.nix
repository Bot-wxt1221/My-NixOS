{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.packages = with pkgs;[
    wl-clip-persist
  ];
}
