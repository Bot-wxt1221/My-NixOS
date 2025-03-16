{
  config,
  ...
}:
{
  imports = [
    ./programs/persist-default.nix
  ];
  systemd.tmpfiles.settings.preservation = {
    "/home/${config.home.username}/.config".d = { user = "${config.home.username}"; group = "users"; mode = "0755"; };
    "/home/${config.home.username}/.local".d = { user = "${config.home.username}"; group = "users"; mode = "0755"; };
    "/home/${config.home.username}/.local/share".d = { user = "${config.home.username}"; group = "users"; mode = "0755"; };
    "/home/${config.home.username}/.local/state".d = { user = "${config.home.username}"; group = "users"; mode = "0755"; };
  };
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
