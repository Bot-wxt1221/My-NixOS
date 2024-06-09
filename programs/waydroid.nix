{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  virtualisation.waydroid.enable = true;
  environment.systemPackages = with pkgs; [
    waydroid
  ];
}
