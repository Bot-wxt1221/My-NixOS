{
  pkgs,
  lib,
  ...
}:

{
  sops.secrets.sing-box = {
    format = "binary";
    sopsFile = ./key-after;
    path = "/etc/sing-box/config-pre.json";
    mode = "0400";
    restartUnits = [ "sing-box.service" ];
  };
  environment.systemPackages = with pkgs; [ sing-box ];
  systemd.services.sing-box = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    wants = [
      "network-online.target"
    ];
    path = with pkgs; [
      coreutils-full
      sing-box
    ];
    serviceConfig =
      let
        script = pkgs.writeScript "a.sh" ''
          #!${pkgs.runtimeShell} -eu
          cat /etc/sing-box/config-pre.json > /var/lib/sing-box/config.json
          if [ -d /var/lib/sing-box/dashboard ]; then
            rm -rf /var/lib/sing-box/dashboard
          fi
          mkdir -p /var/lib/sing-box/dashboard
          cp -r ${pkgs.metacubexd}/*  /var/lib/sing-box/dashboard/
        '';
      in
      {
        StateDirectory = "sing-box";
        StateDirectoryMode = "0700";
        RuntimeDirectory = "sing-box";
        RuntimeDirectoryMode = "0700";
        Type = "simple";
        ExecStartPre = ''
          ${script}
        '';
        ExecStart = [
          "${lib.getExe pkgs.sing-box} -D /var/lib/sing-box -c /var/lib/sing-box/config.json run"
        ];
      };
  };
}
