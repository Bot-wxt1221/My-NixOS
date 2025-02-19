{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [
    ./mininal-hardware-config.nix
    ./persist-config.nix
  ];
  environment.systemPackages = with pkgs; [
    xorg.xf86videovmware
  ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      libva
      libvdpau-va-gl
      vaapiVdpau
      ocl-icd
      intel-ocl
      intel-compute-runtime
      intel-media-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
}
