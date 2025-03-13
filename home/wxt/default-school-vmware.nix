{
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./secret
    ./secret/school-vmware

    ./shared-modules.nix
  ];
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
  programs.git.extraConfig = {
    commit = {
      gpgsign = true;
    };
    user = {
      signingKey = "EF9846DDF6C89DBC294F7741F62181757D8BF693";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
}
