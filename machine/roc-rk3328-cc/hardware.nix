{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./sops
    ./hardware-configuration.nix
  ];
 
  boot = {
    kernelParams = [
      "net.ifnames=0"
      "console=tty1"
      "earlycon"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
  systemd.services."usb-enable" = {
    enable = true;
    script = "${pkgs.libgpiod}/bin/gpioset 1 26=1";
    wantedBy = [ "default.target" ];
  };
}
