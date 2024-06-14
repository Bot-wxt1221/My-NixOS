{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;
}

