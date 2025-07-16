{ pkgs, ... }: {
  stylix.targets.firefox.profileNames = [ "default" ];

  programs.firefox = {
    enable = true;
    betterfox.enable = true;

    profiles.default = {
      id = 0;
      name = "Pavel";

      betterfox = {
        enable = true;
        enableAllSections = true;
      };

      bookmarks = {
        force = true;
        settings = [{
          toolbar = true;
          bookmarks = [
            {
              name = "Opennet";
              url = "https://opennet.ru/";
            }
            {
              name = "Youtube";
              url = "https://www.youtube.com/";
            }
            {
              name = "Vk";
              url = "https://vk.com";
            }
            {
              name = "Rutracker";
              url = "https://rutracker.org";
            }
            {
              name = "Github";
              url = "https://github.com/";
            }
            {
              name = "Rutor";
              url = "https://rutor.is/";
            }
            {
              name = "ChatGPT";
              url = "https://chatgpt.com/";
            }
          ];
        }];
      };

      settings = {
        # Slim tabs
        "browser.uidensity" = 1;

        # Enable HTTPS-Only Mode
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;

        # Privacy settings
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.firstparty.isolate" = true;

        # Disable all sorts of telemetry
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;

        "browser.tabs.crashReporting.sendReport" = false;
        "browser.tabs.crashReporting.email" = false;
        "browser.tabs.crashReporting.emailMe" = false;

        "breakpad.reportURL" = "";
        "security.ssl.errorReporting.automatic" = false;
        "toolkit.crashreporter.infoURL" = "";

        "dom.ipc.plugins.reportCrashUR" = false;
        "dom.ipc.plugins.flash.subprocess.crashreporter.enabled" = false;

        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.previousBuildID" = "";
        "toolkit.telemetry.server_owner" = "";

        "toolkit.tabbox.switchByScrolling" = true;

        "datareporting.healthreport.infoURL" = "";
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.policy.firstRunURL" = "";

        "full-screen-api.warning.timeout" = 0;

        # As well as Firefox 'experiments'
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;

        # Disable Pocket Integration
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          false;
        "extensions.pocket.enabled" = false;
        "extensions.pocket.api" = "";
        "extensions.pocket.oAuthConsumerKey" = "";
        "extensions.pocket.showHome" = false;
        "extensions.pocket.site" = "";

        # Automatically enable extensions
        "extensions.autoDisableScopes" = 0;
      };

      extensions = {
        force = true;

        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          privacy-badger
          sponsorblock
          gesturefy
          return-youtube-dislikes
          enhancer-for-youtube
          vimium
          bitwarden
        ];
        settings = {
          "uBlock0@raymondhill.net".settings = let
            extendedList =
              "https://raw.githubusercontent.com/Zalexanninev15/NoADS_RU/main/ads_list_extended.txt";
          in {
            ignoreGenericCosmeticFilters = true;
            selectedFilterLists = [
              "user-filters"
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-unbreak"
              "ublock-quick-fixes"
              "easylist"
              "easyprivacy"
              "urlhaus-1"
              "plowe-0"
              "RUS-0"
              "RUS-1"
              extendedList
            ];
            externalLists = extendedList;
            importedLists = [ extendedList ];
          };

          "enhancerforyoutube@maximerf.addons.mozilla.org".settings = {
            controls = [ "speed" "options" ];
            newestcomments = true;
            speed = 2;
            theatermode = true;
          };
        };
      };
    };
  };
}
