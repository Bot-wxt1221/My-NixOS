{
  pkgs,
  config,
  lib,
  ...
}:

{
  sops.secrets.mihomo = {
    format = "binary";
    sopsFile = ./key-after;
    mode = "0400";
    restartUnits = [ "mihomo.service" ];
  };
  sops.templates."mihomo.toml".content = ''
    dns:
      use-system-hosts: false
      enable: true
      enhanced-mode: fake-ip
      fake-ip-range: 198.18.0.1/16
      nameserver:
      - 114.114.114.114
      - 223.5.5.5
      - 8.8.8.8
      fallback: []
    profile:
      store-selected: true
    tun:
      stack: gvisor
      device: Mihomo
      auto-route: true
      strict-route: false
      auto-detect-interface: true
      dns-hijack:
      - any:53
      mtu: 1500
      enable: true
      exclude-interface:
      - Tailscale # maybe `utun*` on macOS
      route-exclude-address:
      - 100.64.0.0/10
      - fd7a:115c:a1e0::/48
    ${config.sops.placeholder.mihomo}
  '';
  systemd.services.mihomo = {
    serviceConfig = {
      ExecStartPre = ''
        ${lib.getExe pkgs.bash} ${pkgs.writeText "a.sh" ''
          ${lib.getExe' pkgs.coreutils-full "ln"} -sf ${pkgs.v2ray-geoip}/share/v2ray/geoip.dat /var/lib/private/mihomo/geoip.dat
          ${lib.getExe' pkgs.coreutils-full "ln"} -sf ${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat /var/lib/private/mihomo/geosite.dat
          ${lib.getExe' pkgs.coreutils-full "ln"} -sf ${pkgs.dbip-country-lite.mmdb} /var/lib/private/mihomo/Country.mmdb
        ''}
      '';
    };
  };
  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.nur.repos.linyinfeng.yacd;
    configFile = config.sops.templates."mihomo.toml".path;
  };
}
