{
  sops-nix,
  config,
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
  systemd.tmpfiles.rules = [
    "z ${config.sops.age.keyFile} 0700 root root"
    "z ${config.home-manager.users.wxt.sops.age.keyFile} 0700 wxt wxt"
  ];
}
