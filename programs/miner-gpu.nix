{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  systemd.services.clash-verge-rev = {
    enable = true;
    description = "Lolminer";
    serviceConfig = {
      Environment = "LD_LIBRARY_PATH=/nix/store/${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cudatoolkit}/lib";
      ExecStart = "/home/wxt/.config/lolminer/1.88/lolMiner -a FISHHASH -p iron-asia.f2pool.com:1500 -u zigao.wxt";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
