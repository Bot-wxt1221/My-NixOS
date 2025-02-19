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

}
