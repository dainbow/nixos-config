{ pkgs, ... }: {
  stylix.targets.firefox.profileNames = [ "default" ];

  programs.firefox = {
    enable = true;
    betterfox.enable = true;
    package = pkgs.unstable.firefox;

    profiles.default = {
      id = 0;
      name = "Pavel";

      search = {
        default = "ddg";
        force = true;
      };

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

        "toolkit.tabbox.switchByScrolling" = true;

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
          improved-tube
          return-youtube-dislikes
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
          "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}".settings = {
            player_forced_playback_speed = true;
            player_dont_speed_education = false;
            player_playback_speed = 2;
            ads = "block_all";
            hide_banner_ads = true;
            remove_member_only = true;
          };
        };
      };
    };
  };
}
