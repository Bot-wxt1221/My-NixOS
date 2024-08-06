{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkDefault "va_gl");
  };

  hardware.graphics.extraPackages = with pkgs; [
    (
      if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then
        vaapiIntel
      else
        intel-vaapi-driver
    )
    libvdpau-va-gl
    intel-media-driver
  ];

  hardware.graphics.extraPackages32 = with pkgs.driversi686Linux; [
    (
      if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then
        vaapiIntel
      else
        intel-vaapi-driver
    )
    libvdpau-va-gl
    intel-media-driver
  ];
}
