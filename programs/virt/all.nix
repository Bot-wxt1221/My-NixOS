{ config, lib, pkgs, ... }:
{
  imports = [
    ./intel-gpu.nix
  ];
  virtualisation.libvirtd.enable = true;
  virtualisation.vswitch.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
