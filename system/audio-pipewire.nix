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
    environment.systemPackages = with pkgs; [ alsa-firmware sof-firmware ];
    environment.etc."wxt/panel/bin".source = "${pkgs.pwvucontrol}/bin/pwvucontrol";
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
