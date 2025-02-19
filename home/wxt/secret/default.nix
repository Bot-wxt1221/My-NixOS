{
  config,
  pkgs,
  lib,
  sops-nix,
  osConfig,
  ...
}:

{
  imports = [
    ./2FA
  ];
  sops.age.keyFile = osConfig.sops.age.keyFile;
  # Only for trusted user!
  home.activation.copy-age-key = ''
    mkdir -p ${config.home.homeDirectory}/.config/sops/age
    cp -rf ${config.sops.age.keyFile} ${config.home.homeDirectory}/.config/sops/age/keys.txt
  '';
}
