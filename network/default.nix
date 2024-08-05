{ config, lib, pkgs, ... }:
{
  imports = [
    ./firewall.nix
  ];
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
}
