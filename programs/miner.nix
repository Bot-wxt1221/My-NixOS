{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  environment.systemPackages = [
    pkgs.xmrig
  ];
  services.xmrig.enable = true;
  services.xmrig.settings = libs.fromJSON (libs.readFile "miner.json");
}
