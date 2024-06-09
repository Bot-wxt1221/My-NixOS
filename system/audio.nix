{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  environment.systemPackages = with pkgs; [
    alsa-firmware
  ];
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
