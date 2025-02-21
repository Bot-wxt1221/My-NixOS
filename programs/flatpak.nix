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
    after = [ "display-manager.service" ];
    path = [ pkgs.flatpak ];
    serviceConfig.Type = "oneshot";
    script = ''
      sleep 10
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
