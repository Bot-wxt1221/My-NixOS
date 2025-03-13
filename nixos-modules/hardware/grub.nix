{
  ...
}:
{
  imports = [

  ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
}
