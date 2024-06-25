{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  systemd.services.miner-gpu = {
    enable = true;
    description = "Lolminer";
    serviceConfig = {
      Environment = "LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cudatoolkit}/lib NIX_LD=/run/current-system/sw/share/nix-ld/lib/ld.so";
      ExecStart = "/home/wxt/.config/gminer/miner --algo etchash --server stratum-etc.antpool.com:8008 --user 0x4218E7fF553587087556fe8d1DeC3FCd71d0fb3c.wxt  --watchdog 0";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
