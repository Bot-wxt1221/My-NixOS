{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    enableChromium = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  config = lib.mkIf config.enableChromium {
    programs.chromium.enable = true;
    preservation.preserveAt."/persist".users.wxt = {
      directories = [
        ".config/chromium"
      ];
    };
    environment.sessionVariables = {
      GOOGLE_API_KEY = "$(cat ${config.sops.secrets.GOOGLE_API_KEY.path})";
      GOOGLE_DEFAULT_CLIENT_SECRET = "$(cat ${config.sops.secrets.GOOGLE_DEFAULT_CLIENT_SECRET.path})";
      GOOGLE_DEFAULT_CLIENT_ID = "$(cat ${config.sops.secrets.GOOGLE_DEFAULT_CLIENT_ID.path})";
    };
    home-manager.sharedModules = [
      (
        {
          osConfig,
          lib,
          ...
        }:
        {
          config = lib.mkIf osConfig.enableChromium {
            programs.chromium.enable = true;
            programs.chromium.commandLineArgs = [
              "--process-per-site"
              "--ozone-platform-hint=wayland"
              "--enable-wayland-ime"
              "--wayland-text-input-version=3"
              "--enable-features=AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
              "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
              "--enable-features=UseMultiPlaneFormatForHardwareVideo"
              "--ignore-gpu-blocklist"
              "--enable-zero-copy"
            ];
            programs.chromium.package = pkgs.chromium;
            programs.chromium.extensions = import ./extensions.nix {
              inherit pkgs;
            };
          };
        }
      )
    ];
    programs.chromium.defaultSearchProviderSuggestURL = "https://www.bing.com/osjson.aspx?query={searchTerms}";
    programs.chromium.defaultSearchProviderSearchURL = "https://www.bing.com/search?q={searchTerms}";
    programs.chromium.defaultSearchProviderEnabled = true;
    programs.chromium.extraOpts = {
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "HomePageLocation" = "https://www.bing.com";
      "NewTabPageLocation" = "https://www.bing.com";
    };
  };
}
