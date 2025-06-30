{
  config,
  pkgs,
  user,
  ...
}:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  lock-empty-string = {
    Value = "";
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";

      Preferences = {
        # Privacy settings
        "extensions.pocket.enabled" = lock-false;
        "browser.newtabpage.pinned" = lock-empty-string;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
  home-manager.users.${user} = {
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.uidensity" = 0;
            "svg.context-properties.content.enabled" = true;
            "browser.theme.dark-private-windows" = false;
            "widget.gtk.rounded-bottom-corners.enabled" = true;
            "browser.startup.homepage" = "https://start.duckduckgo.com";
            "browser.search.defaultenginename" = "DuckDuckGo";
            "browser.search.order.1" = "DuckDuckGo";
            "signon.rememberSignons" = false;
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "browser.newtabpage.enabled" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.compactmode.show" = true;
            "browser.cache.disk.enable" = false; # Be kind to hard drive
            "widget.disable-workspace-management" = true;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.suggest.trending" = false;
            "browser.urlbar.showSearchSuggestionsFirst" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.history" = false;
            "browser.contentblocking.category" = "strict";
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.cachedClientID" = "";
            "toolkit.telemetry.cachedProfileGroupID" = "";
            "datareporting.dau.cachedUsageProfileID" = "";
            "datareporting.dau.cachedUsageProfileGroupID" = "";
            "privacy.sanitize.sanitizeOnShutdown" = true;
            "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
            "privacy.clearOnShutdown_v2.formdata" = true;
            "network.dns.disablePrefetch" = true;
            "network.predictor.enabled" = false;
            "network.prefetch-next" = false;
            "browser.contextual-services.contextId" = "";
            "browser.search.suggest.enabled" = false;
          };
          search = {
            force = true;
            engines = {
              bing.metaData.hidden = true;
              wikipedia.metaData.hidden = true;
              ebay.metaData.hidden = true;
              google.metaData.hidden = true;
              amazon.metaData.hidden = true;
            };
            default = "ddg";
            order = [
              "ddg"
            ];
          };
        };
      };
    };
  };
}
