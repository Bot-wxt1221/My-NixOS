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

  sops.age.keyFile = lib.mkForce "/var/lib/sops-nix/key.txt";

  boot = {
    kernelParams = [
      "net.ifnames=0"
      "console=tty1"
      "earlycon"
      "console=ttyS2,1500000n8"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
}
