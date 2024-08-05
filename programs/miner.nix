{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  options = {
  EnableMineCPU = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

  };
  config = lib.mkIf config.EnableMineCPU {
  environment.systemPackages = [
    pkgs.xmrig
  ];
  services.xmrig.enable = true;
  services.xmrig.settings = builtins.fromJSON (builtins.readFile ./miner.json);
  };
}
