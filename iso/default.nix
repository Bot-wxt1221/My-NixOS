{
  config,
  pkgs,
  modulesPath,
  lib,
  ...
}:
with rec {
  config = pkgs.writeText "clash-verge.yaml" (
    ''
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
    ''
    + (builtins.readFile ./config.yaml)
  );

  mihomoBash = pkgs.writeText "a.sh" ''
    ln -s ${pkgs.v2ray-geoip}/share/v2ray/geoip.dat /root/geoip.dat
    ln -s ${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat /root/geosite.dat
    ln -s ${pkgs.dbip-country-lite.mmdb} /root/Country.mmdb
    ${lib.getExe pkgs.mihomo} -f ${config} -d /root
  '';
};
{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
    ../nixos-modules/programs/nix
    ../nixos-modules/programs/root-utils.nix
  ];
  config = {
    documentation.man.enable = false;
    hardware.enableRedistributableFirmware = true;
    isoImage.makeUsbBootable = true;
    isoImage.makeEfiBootable = true;
    environment.systemPackages = with pkgs; [
      mihomo
    ];
    networking.networkmanager.enable = true;
    networking.useNetworkd = false;
    networking.wireless.enable = false;
    environment.etc."config" = {
      enable = true;
      source = ./..;
    };
    environment.etc."perpare.sh" = {
      enable = true;
      text = ''
        cd /mnt
        git clone https://github.com/Bot-wxt1221/My-NixOS
      '';
      mode = "7777";
    };
    environment.etc."resolv.conf" = {
      enable = true;
      text = ''
        nameserver 223.5.5.5
        nameserver 8.8.8.8
        nameserver 1.1.1.1
      '';
    };
    systemd.services.mihomo = {
      enable = true;

      wantedBy = [ "multi-user.target" ];

      wants = [
        "network-online.target"
      ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe pkgs.bash} ${mihomoBash}";
      };
    };
  };
}
