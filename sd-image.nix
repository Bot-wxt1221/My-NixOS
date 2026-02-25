# save as sd-image.nix somewhere
{
  pkgs,
  lib,
  modulesPath,
  ...
}:
let
  uboot = pkgs.fetchurl {
    url = "http://boot.libre.computer/release/roc-rk3328-cc/roc-rk3328-cc-boot.bin";
    hash = "sha256-Y5yMmU/LyMVJi94vrYDpBM+4qwUfILwP+gVUToAXteA=";
  };
in
{
  imports = [
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  nixpkgs.config.allowUnfree = true; # needed for ubootRock64
  # at the time of writing the u-boot version from FireFly hasn't been successfully ported yet
  # so we use the one from Rock64

  # put your own configuration here, for example ssh keys:
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9YcmQFwhORiIfvNVPVkOXWshLO7yhCYwMOb5BC91uJ wxt@wxt-g3"
  ];
  sdImage.postBuildCommands = ''
    dd if=${uboot} of=$img conv=fsync,notrunc bs=512 seek=64
  '';
  boot.supportedFilesystems.zfs = lib.mkForce false;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "net.ifnames=0"
    "console=tty1"
    "earlycon"
    "console=ttyS2,1500000n8"
    "modprobe.blacklist=fusb302"
  ];
  services.openssh.enable = true;

  networking.firewall.enable = false;

  users.users.root.password = "1";
}
