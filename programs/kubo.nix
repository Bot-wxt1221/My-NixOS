{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  services.kubo = {
    enable = true;
    user = "wxt";
    enableGC = false;
    autoMount = true;
  };
}
