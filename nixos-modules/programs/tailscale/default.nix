{
  config,
  ...
}:
{
  sops.secrets.tailscale = {
    format = "binary";
    sopsFile = ./key-after;
    mode = "0444";
  };
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--advertise-exit-node"
      "--advertise-routes=192.168.10.0/23,192.168.20.0/23,192.168.30.0/24,192.168.40.0/23,192.168.99.0/24"
      "--accept-routes"
      "--accept-dns=false"
    ];
    authKeyFile = config.sops.secrets.tailscale.path;
  };
}
