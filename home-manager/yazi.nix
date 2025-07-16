{ lib, pkgs, config, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
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
