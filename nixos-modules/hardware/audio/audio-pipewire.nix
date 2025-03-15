{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    Enablepipewire = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.Enablepipewire {
    environment.systemPackages = with pkgs; [
      alsa-firmware
      sof-firmware
    ];
    systemd.tmpfiles.rules = [
      "w! /sys/class/rtc/rtc0/max_user_freq - - - - 3072"
      "w! /proc/sys/dev/hpet/max-user-freq  - - - - 3072"
    ];
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    hardware.firmware = [
      pkgs.alsa-firmware
      pkgs.sof-firmware
    ];
  };
}
