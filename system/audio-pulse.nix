{ config, lib, pkgs, ... }:
{
  options = {
    Enablepulseaudio = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.Enablepulseaudio {
    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
