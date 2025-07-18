{ lib, pkgs, config, inputs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.yazi.override {
      extraPackages = with pkgs.unstable; [ mediainfo ];
    };

    plugins = {
      simple-tag = "${inputs.yazi-simple-tag}/";
      torrent-preview = "${inputs.yazi-torrent-preview}/";
      mediainfo = "${inputs.yazi-mediainfo}/";
    };

    initLua = # lua
      ''
        require("simple-tag"):setup({
        })
      '';

    keymap = {
      mgr.prepend_keymap = [{
        on = [ "`" ];
        run = "plugin simple-tag -- toggle-tag --keys=*";
      }];
    };

    settings = {
      plugin = {
        append_fetchers = [
          {
            id = "simple-tag";
            name = "*";
            run = "simple-tag";
          }

          {
            id = "simple-tag";
            name = "*/";
            run = "simple-tag";
          }
        ];

        prepend_preloaders = [
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }

          {
            mime = "application/subrip";
            run = "mediainfo";
          }

          {
            mime = "application/postscript";
            run = "mediainfo";
          }

        ];
        prepend_previewers = [
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
          {
            mime = "application/bittorrent";
            run = "torrent-preview";
          }
        ];
      };

      open = {
        rules = [
          {
            use = [ "imager" "copy" ];
            mime = "image/*";
          }
          {
            use = [ "play" "copy" ];
            mime = "video/*";
          }
          {
            use = [ "play" "copy" ];
            mime = "audio/*";
          }
        ];
      };

      opener = {
        play = [{
          run = ''${lib.getExe config.programs.mpv.finalPackage} "$@"'';
          orphan = true;
        }];

        imager = [{
          run = ''${lib.getExe pkgs.loupe} "$@"'';
          orhan = true;
        }];

        copy = [{
          run = ''wl-copy < "$@"'';
          orhan = true;
        }];
      };
    };
  };
}
