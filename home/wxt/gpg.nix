{ config, pkgs, ... }:
{
  imports = [

  ];
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
