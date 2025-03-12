{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  options = {
    EnableMineGPU = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.EnableMineGPU {
    systemd.services.miner-gpu = {
      enable = true;
      description = "Lolminer";
      serviceConfig = {
        Environment = "LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cudatoolkit}/lib NIX_LD=/run/current-system/sw/share/nix-ld/lib/ld.so";
        ExecStart = "/home/wxt/.config/gminer/miner --algo kawpow --server clore.2miners.com:2020 --user UQDbR3PFYf6J5yUSV7mxwnyZAM3aVxrPIzBYQyFglYQyei6S.wxt --watchdog 0";
        Restart = "on-failure";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
