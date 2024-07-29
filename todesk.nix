{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.todesk;
in
{
  options = {

    services.todesk2.enable = lib.mkEnableOption "ToDesk daemon";
    services.todesk2.package = lib.mkPackageOption pkgs "todesk" { };
    services.todesk2 = {
      user = lib.mkOption {
        type = lib.types.str;
        default = "todesk";
        description = ''
          ToDesk User.
        '';
      };

      group = lib.mkOption {
        type = lib.types.str;
        default = "todesk";
        description = ''
          ToDesk group. Users who want to use `todesk` need to be part of this group.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ cfg.package ];

    users.users.${cfg.user} = {
      description = "ToDesk user";
      uid = config.ids.uids.todesk;
      group = cfg.group;
    };

    users.groups.${cfg.group} = {
      gid = config.ids.gids.todesk;
    };

    systemd.services.todeskd = {
      description = "ToDesk Daemon Service";

      wantedBy = [ "multi-user.target" ];
      wants = [
        "network-online.target"
	"display-manager.service"
        "nss-lookup.target"
      ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${cfg.package}/bin/todesk service";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGINT $MAINPID";
        Restart = "on-failure";
        User = "root";
        Group = "root";
        WorkingDirectory = "/var/lib/todesk";
        StateDirectory = "todesk";
        StateDirectoryMode = "0777"; # Desktop application read /opt/todesk/config/config.ini. Such a pain!
#        ProtectSystem = "strict";
        ProtectHome = "read-only";
#        PrivateTmp = "yes";
        RemoveIPC = "yes";
      };
    };
  };
}
