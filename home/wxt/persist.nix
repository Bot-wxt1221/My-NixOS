{
  config,
  lib,
  pkgs,
  impermanence,
  ...
}:
{
  imports = [
    impermanence.homeManagerModules.impermanence
  ];
  home.persistence."/persistent/home/wxt" = {
    directories = [
      "Downloads"
      "Music"
      "Working"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local"
      ".config"
    ];
    allowOther = true;
  };
}
