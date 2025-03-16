{
  config,
  ...
}:
{
  imports = [
    ./programs/persist-default.nix
  ];
  preservation.preserveAt."/persist".users.wxt = {
    commonMountOptions = [
      "x-gvfs-hide"
    ];
    directories = [
      "Downloads"
      "Music"
      "Working"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".config/direnv"
      ".local/share/direnv"
    ];
  };
}
