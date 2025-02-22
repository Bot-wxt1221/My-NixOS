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
          programs.chromium.package = pkgs.ungoogled-chromium;
          programs.chromium.extensions = import ./chromium-extensions.nix {
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
