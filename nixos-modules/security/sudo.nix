{
  pkgs,
  ...
}:
{
  imports = [ ];
  security.sudo.wheelNeedsPassword = true;
  systemd.services.idontwanttoreadstupidsudolecture = {
    enable = true;
    description = "I don't want to read stupid sudo lecture";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /var/db/sudo/lectured 
      touch /var/db/sudo/lectured/1000
    '';
    wantedBy = [ "multi-user.target" ];
  };
  security.wrappers = {
    pkexec = {
      setuid = true;
      owner = "root";
      group = "root";
      source = "${pkgs.polkit.bin}/bin/pkexec";
    };
  };
}
