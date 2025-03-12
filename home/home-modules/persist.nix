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
  home.persistence."/persist/home/wxt" = {
    enable = true;
    directories = [
      "Downloads"
      "Music"
      {
        directory = "Working";
        method = "symlink";
      }
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
    ];
    allowOther = true;
  };
}
