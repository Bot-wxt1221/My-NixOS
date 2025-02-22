{
  pkgs,
  lib,
  ...
}:
{
  programs.chromium.enable = true;
  home-manager.sharedModules = [
    (
      {
        config,
        lib,
        ...
      }:
      {
        options = {
          enableChromium = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
        };
        config = lib.mkIf config.enableChromium {
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
          programs.chromium.package = pkgs.ungoogled-chromium;
          programs.chromium.extensions = import ./extensions.nix {
            inherit pkgs lib;
          };
        };
      }
    )
  ];
  programs.chromium.defaultSearchProviderSuggestURL = "https://www.bing.com/osjson.aspx?query={searchTerms}";
  programs.chromium.defaultSearchProviderSearchURL = "https://www.bing.com/search?q={searchTerms}";
  programs.chromium.defaultSearchProviderEnabled = true;
  programs.chromium.extraOpts = {
    "BrowserSignin" = 0;
    "SyncDisabled" = true;
    "PasswordManagerEnabled" = false;
    "SpellcheckEnabled" = true;
    "HomePageLocation" = "https://www.bing.com";
    "NewTabPageLocation" = "https://www.bing.com";
  };
}
