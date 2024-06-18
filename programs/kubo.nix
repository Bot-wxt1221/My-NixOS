{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  services.kubo = {
    enable = true;
    user = "wxt";
    enableGC = false;
    autoMount = true;
    settings.Addresses.API = ["/ip4/127.0.0.1/tcp/5001"];
    Datastore.StorageMax = "100GB";
  };
}
