{
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./secret
    ./secret/g3

    ./shared-modules.nix
  ];
  cpuTempDevice = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
  haveBacklight = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
  programs.git.extraConfig = {
    commit = {
      gpgsign = true;
    };
    user = {
      signingKey = "E834B5093C621EFE92D7CC1AF41E2366C0EDC8BC";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
  audioProcess = ''
    sleep 5
    ponymix -t source  --device "alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Mic1__source" set-default && ponymix -t source  --device "alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Mic1__source" mute && ponymix -t source  --device "alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Mic1__source" unmute
    ponymix -t sink  --device "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink" set-default && ponymix -t sink  --device "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink" mute && ponymix -t sink  --device "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink" unmute
  '';
}
