{
  pkgs,
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
          programs.chromium.dictionaries = [
            pkgs.hunspellDictsChromium.en_US
          ];
          programs.chromium.extensions = [
            { id = "kpbnombpnpcffllnianjibmpadjolanh"; } # bilibili
            { id = "fpnmgdkabkmnadcjpehmlllkndpkmiak"; } # Wayback Machine
            { id = "bfbmjmiodbnnpllbbbfblcplfjjepjdn"; } # Turn off light for videos
            { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; } # Tampermonkey
            { id = "ajkhmmldknmfjnmeedkbkkojgobmljda"; } # CRX Extractor/Downloader
            { id = "gakohpplicjdhhfllilcjpfildodfnnn"; } # Carrot
            { id = "cjnmckjndlpiamhfimnnjmnckgghkjbl"; } # Competitive Companion
            { id = "oboonakemofpalcgghocfoadofidjkkk"; } # KeePassXC
            { id = "jnbbnacmeggbgdjgaoojpmhdlkkpblgi"; } # WakaTime
          ];
        };
      }
    )
  ];
  programs.chromium.extraOpts = {
    "BrowserSignin" = 0;
    "SyncDisabled" = true;
    "PasswordManagerEnabled" = false;
    "SpellcheckEnabled" = true;
    "HomePageLocation" = "about:blank";
    "NewTabPageLocation" = "about:blank";
    "DefaultSearchProviderName" = "bing";
    "DefaultSearchProviderSearchURL" = "https://www.bing.com/search?q={searchTerms}";
    "DefaultSearchProviderKeyword" = "bing";
  };
}
