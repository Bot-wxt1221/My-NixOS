{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];
  virtualisation.libvirtd.enable = true;
  virtualisation.vswitch.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];
}
