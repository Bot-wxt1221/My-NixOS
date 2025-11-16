# save as sd-image.nix somewhere
{
  pkgs,
  lib,
  modulesPath,
  ...
}:
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
sdImage.postBuildCommands = with pkgs; ''
    dd if=${ubootRock64}/idbloader.img of=$img conv=fsync,notrunc bs=512 seek=64
    dd if=${ubootRock64}/u-boot.itb of=$img conv=fsync,notrunc bs=512 seek=16384
  '';
  boot.supportedFilesystems.zfs = lib.mkForce false;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "net.ifnames=0"
    "console=tty1"
    "earlycon"
    "console=ttyS2,1500000n8"
  ];
  services.openssh.enable = true;

  networking.firewall.enable = false;

  users.users.root.password = "1";
}
