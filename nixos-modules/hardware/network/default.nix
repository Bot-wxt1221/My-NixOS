{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./firewall.nix ];
  options = {
    Ownhostname = lib.mkOption {
      type = lib.types.str;
      default = "wxt";
      example = "wxt";
      description = "NixOS Hostname";
    };
  };
  config = {
    networking.hostName = config.Ownhostname; # Define your hostname.
    networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
    networking.useNetworkd = false;
  };
}
