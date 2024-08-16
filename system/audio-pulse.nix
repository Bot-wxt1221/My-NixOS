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
    hardware.pulseaudio.enable = true;
    hardware.firmware = [
      pkgs.alsa-firmware
      pkgs.sof-firmware
    ];

    environment.etc."wxt/panel/bin".source = "${pkgs.pavucontrol}/bin/pavucontrol";
  };
}
