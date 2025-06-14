_: {
  boot.loader.systemd-boot = {
    enable = true;
    memtest86.enable = true;
    edk2-uefi-shell.enable = true;
    netbootxyz.enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
