{
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./secret
    ./secret/g3
    ./utils.nix

    ./shared-modules.nix
  ];
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
  programs.git.settings = {
    commit = {
      gpgsign = true;
    };
    user = {
      signingKey = "1A9AF0CD73FBFCAB38654B3C7EF312CD7C4C830C";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
}
