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
    path = [ pkgs.flatpak ];
    oneshot = true;
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
