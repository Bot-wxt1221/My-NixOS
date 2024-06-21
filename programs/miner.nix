{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  environment.systemPackages = [
    pkgs.xmrig
  ];
  services.xmrig.enable = true;
  services.xmrig.settings = builtins.fromJSON (builtins.readFile "miner.json");
}
