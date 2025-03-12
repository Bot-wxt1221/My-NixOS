{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  services.flatpak.enable = true;
  environment.persistence."/persist".directories = [ "/var/lib/flatpak" ];
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    after = [ "NetworkManager-wait-online.service" ];
    path = [ pkgs.flatpak ];
    serviceConfig.Type = "oneshot";
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
