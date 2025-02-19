{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:
{
  imports = [ ./cache.nix ];
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "12:00" ]; # Optional; allows customizing optimisation schedule
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "auto-allocate-uids"
    "ca-derivations"
    "cgroups"
    "dynamic-derivations"
  ];
  nixpkgs.config.allowUnfree = true;
  system.rebuild.enableNg = true;
  nix.registry.nixpkgs.flake = nixpkgs;
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
  nix.package = pkgs.lix;
}
