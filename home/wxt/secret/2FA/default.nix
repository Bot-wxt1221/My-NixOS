{
  config,
  ...
}:

{
  sops.secrets.passwordDateBase = {
    format = "binary";
    sopsFile = ./pas2s.kdbx.after;
    path = "${config.home.homeDirectory}/2FA/pas2s.kdbx.before";
    mode = "0400";
  };
  sops.secrets.passwordDateBaseSecret = {
    format = "binary";
    sopsFile = ./kee.after;
    path = "${config.home.homeDirectory}/2FA/kee.before";
    mode = "0400";
  };
  systemd.user.services.keepassxc = {
    Unit = {
      Description = "keepassxc password manager";
      Wants = [ "tray.target" ];
      Requires = [ "sops-nix.service" ];
      After = [
        "sops-nix.service"
        "tray.target"
      ];
      PartOf = [ "graphical-session.target" ];
    };

    Install.WantedBy = [ "xdg-desktop-autostart.target" ];

    Service = {
      Type = "exec";
      Restart = "on-abnormal";
      ExecStart = ''
        install -Dm600 ${config.home.homeDirectory}/2FA/kee.before ${config.home.homeDirectory}/2FA/kee
        install -Dm600 ${config.home.homeDirectory}/2FA/pas2s.kdbx.before ${config.home.homeDirectory}/2FA/pas2s.kdbx
      '';
    };
  };
}
