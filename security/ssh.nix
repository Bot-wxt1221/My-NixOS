{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.openssh.enable = true;
}
