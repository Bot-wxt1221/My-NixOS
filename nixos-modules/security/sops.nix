{
  pkgs,
  config,
  lib,
  sops-nix,
  ...
}:

{
  imports = [
    sops-nix.nixosModules.sops
  ];
  home-manager.sharedModules = [
    sops-nix.homeManagerModules.sops
  ];
  sops.age.keyFile = "/persist/var/lib/sops-nix/key.txt";
}
