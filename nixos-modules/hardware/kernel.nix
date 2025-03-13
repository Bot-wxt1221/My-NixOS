{
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  hardware.firmware = [ pkgs.linux-firmware ];
  boot.kernel.sysctl = {
    "kernel.sysrq" = 255;
  };
  security.pam.services.systemd-run0 = {
    setEnvironment = true;
    pamMount = false;
  };
  systemd.tmpfiles.settings."zswap" = {
    "/sys/module/zswap/parameters/enabled"."w-".argument = "1";
    "/sys/module/zswap/parameters/zpool"."w-".argument = "zsmalloc";
  };
}
