{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware/school-vmware.nix
    ./network
    ./security
    ./printing.nix
    ./font.nix
    ./programs
    ./system
  ];
  time.timeZone = "Asia/Shanghai";
  Enablepulseaudio = true;
  Ownhostname = "wxt-school-vmware";
}
