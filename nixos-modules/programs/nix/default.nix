{
  lib,
  pkgs,
  nixpkgs,
  inputs,
  ...
}:
{
  imports = [ ./cache.nix ];
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "12:00" ]; # Optional; allows customizing optimisation schedule
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 2d --keep 3";
      dates = "*-*-* 12:00:00 UTC";
    };
    flake = "/home/wxt/Working/config";
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "auto-allocate-uids"
    "ca-derivations"
    "cgroups"
    "dynamic-derivations"
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "clash-verge-rev-2.2.3"
  ];
  system.extraDependencies =
    let
      collectFlakeInputs =
        input:
        [ input ] ++ builtins.concatMap collectFlakeInputs (builtins.attrValues (input.inputs or { }));
    in
    builtins.concatMap collectFlakeInputs (builtins.attrValues inputs);
  nixpkgs.config.allowUnfree = true;
  system.rebuild.enableNg = true;
  nix.registry.nixpkgs.flake = nixpkgs;
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
  nix.package = pkgs.lixPackageSets.latest.lix;
}
