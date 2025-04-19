{
  pkgs,
  ...
}:
{
  imports = [

  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.firmware = [ pkgs.linux-firmware ];
  boot.kernel.sysctl = {
    "kernel.sysrq" = 255;
  };
  security.pam.services.systemd-run0 = {
    setEnvironment = true;
    pamMount = false;
  };
  services.fwupd.enable = true;
  systemd.tmpfiles.settings."zswap" = {
    "/sys/module/zswap/parameters/enabled"."w-".argument = "1";
    "/sys/module/zswap/parameters/zpool"."w-".argument = "zsmalloc";
  };
}
