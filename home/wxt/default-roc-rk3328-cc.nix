{
  osConfig,
  ...
}:

{
  imports = [
    ./secret
    ./secret/g3
    ./utils-aarch64.nix

    ./shared-modules.nix
  ];
  haveBacklight = false;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
}
