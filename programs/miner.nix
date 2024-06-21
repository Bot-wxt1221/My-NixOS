{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  environment.systemPackages = [
    pkgs.xmrig
  ];
  services.xmrig.enable = true;
  services.xmrig.settings = lib.fromJSON (lib.readFile (.+"miner.json"));
}
