{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  systemd.services.miner-gpu = {
    enable = false;
    description = "Lolminer";
    serviceConfig = {
      Environment = "LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cudatoolkit}/lib NIX_LD=/run/current-system/sw/share/nix-ld/lib/ld.so";
      ExecStart = "/home/wxt/.config/gminer/miner --algo kawpow --server clore.2miners.com:2020 --user AazFdbXqTwA1FhQZhTFUwv4Af4S7u5WPws.wxt --watchdog 0";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
