{ config, lib, pkgs, ... }:
{
  imports = [
    ./firewall.nix
  ];
  networking.hostName = "wxt"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
}
