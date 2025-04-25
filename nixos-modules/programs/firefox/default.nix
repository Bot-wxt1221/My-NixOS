{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    enableFirefox = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  config = lib.mkIf config.enableFirefox {
    preservation.preserveAt."/persist".users.wxt = {
      directories = [
        ".cache/mozilla"
        ".mozilla/firefox/botwxt"
      ];
    };
    systemd.tmpfiles.settings.preservation = {
      "/home/wxt/.mozilla".d = {
        user = "wxt";
        group = "users";
        mode = "0755";
      };
      "/home/wxt/.mozilla/firefox".d = {
        user = "wxt";
        group = "users";
        mode = "0755";
      };
    };
    programs.firefox = {
      languagePacks = [
        "zh-CN"
      ];
    };
    home-manager.sharedModules = [
      (_: {
        config = {
          programs.firefox = {
            enable = true;
            languagePacks = [
              "zh-CN"
            ];
            nativeMessagingHosts = [
              pkgs.keepassxc
            ];
            package = pkgs.wrapFirefox (pkgs.firefox-beta-unwrapped.override {
              pipewireSupport = true;
              ffmpegSupport = true;
            }) { };
            profiles.botwxt = {
              isDefault = true;
              name = "BotIsNotBot";
              extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
                keepassxc-browser
                wayback-machine
                tampermonkey
                competitive-companion
                wakatimes
              ];
              search = {
                force = true;
                default = "bing";
                engines = {
                  nix-packages = {
                    name = "Nix Packages";
                    urls = [
                      {
                        template = "https://search.nixos.org/packages";
                        params = [
                          {
                            name = "type";
                            value = "packages";
                          }
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];
                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = [ "@np" ];
                  };
                  nixos-wiki = {
                    name = "NixOS Wiki";
                    urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                    iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                    definedAliases = [ "@nw" ];
                  };
                };
              };
              settings = {
                "browser.startup.homepage" = "https://www.bing.com";
                "browser.tabs.loadInBackground" = true;
                "browser.fullscreen.autohide" = true;
                "browser.newtabpage.activity-stream.feeds.topsites" = false;
                "browser.urlbar.keepPanelOpenDuringImeComposition" = true;
                "widget.use-xdg-desktop-portal.file-picker" = 1;
                "browser.uiCustomization.horizontalTabstrip" =
                  ''["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"]'';
                "sidebar.verticalTabs" = true;
              };
            };
          };
        };
      })
    ];
  };
}
