{
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./secret
    ./secret/g3
    ./utils-aarch64.nix

    ./shared-modules.nix
  ];
  enableDesktop = false;
  programs.thunderbird.enable = lib.mkForce false;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  sops.age.keyFile = lib.mkForce "/home/wxt/.config/sops/age/key.txt";
  programs.home-manager.enable = true;
}
