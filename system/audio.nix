{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  environment.systemPackages = with pkgs; [
    alsa-firmware
  ];
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.firmware = [ pkgs.alsa-firmware ];
  services.pipewire.extraConfig.pipewire-pulse."92-low-latency" = {
    context.modules = [
      {
        name = "libpipewire-module-protocol-pulse";
        args = {
          pulse.min.req = "2560/48000";
          pulse.default.req = "2560/48000";
          pulse.max.req = "2560/48000";
          pulse.min.quantum = "2560/48000";
          pulse.max.quantum = "2560/48000";
        };
      }
    ];
    context.properties = {
      default.clock.rate = 48000;
      default.clock.quantum = 2560;
      default.clock.min-quantum = 2560;
      default.clock.max-quantum = 2560;
    };
    stream.properties = {
      node.latency = "2560/48000";
      resample.quality = 1;
    };
  };
}
