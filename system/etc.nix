{
  config,
  lib,
  pkgs,
  ...
}:
{
  system.etc.overlay.enable = true;
  boot.initrd.systemd.enable = true;
  users.mutableUsers = false;
}
