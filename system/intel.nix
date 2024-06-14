{config ,pkgs, lib, ...}:{
    environment.variables = {
      VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
    };

    hardware.opengl.extraPackages = with pkgs; [
      (
        if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then
          vaapiIntel
        else
          intel-vaapi-driver
      )
      libvdpau-va-gl
      intel-media-driver
    ];

    hardware.opengl.extraPackages32 = with pkgs.driversi686Linux; [
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
