{
  config,
  pkgs,
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./gpg.nix
    ./direnv.nix
    ./desktop
    ./programs
    ./debug-cc.nix
    ./persist.nix
    ./virt.nix
    ./java.nix
    ./utils.nix
    ./nix.nix
    ./zsh.nix
    ./git.nix
  ];
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
  programs.git.signing.format = lib.mkForce "openpgp";
}
