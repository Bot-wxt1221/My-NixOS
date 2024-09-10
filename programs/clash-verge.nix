{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  programs.clash-verge.autoStart = true;
  systemd.services.clash-verge-rev = {
    enable = true;
    description = "clash verge rev";
    serviceConfig = {
      ExecStart = "${pkgs.clash-verge-rev}/bin/clash-verge-service";
    };
    wantedBy = [ "multi-user.target" ];
  };
  environment.systemPackages = with pkgs; [ clash-verge-rev ];
}
