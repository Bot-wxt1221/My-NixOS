{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    Enablepulseaudio = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.Enablepulseaudio {
    services.pulseaudio.enable = true;
    services.pipewire.enable = false;
    hardware.firmware = [
      pkgs.alsa-firmware
      pkgs.sof-firmware
    ];
    systemd.tmpfiles.rules = [
      "w! /sys/class/rtc/rtc0/max_user_freq - - - - 3072"
      "w! /proc/sys/dev/hpet/max-user-freq  - - - - 3072"
    ];
  };
}
