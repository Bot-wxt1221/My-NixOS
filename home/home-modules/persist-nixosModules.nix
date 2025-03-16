{
  config,
  ...
}:
{
  imports = [
    ./programs/persist-default.nix
  ];
  systemd.tmpfiles.settings.preservation = {
    "/home/wxt/.config".d = {
      user = "wxt";
      group = "users";
      mode = "0755";
    };
    "/home/wxt/.local".d = {
      user = "wxt";
      group = "users";
      mode = "0755";
    };
    "/home/wxt/.local/share".d = {
      user = "wxt";
      group = "users";
      mode = "0755";
    };
    "/home/wxt/.local/state".d = {
      user = "wxt";
      group = "users";
      mode = "0755";
    };
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
