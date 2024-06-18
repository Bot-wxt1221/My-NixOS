{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  services.kubo = {
    enable = true;
    user = "wxt";
    enableGC = false;
    autoMount = true;
    Addresses.API = ["127.0.0.1:5001"]
  };
}
