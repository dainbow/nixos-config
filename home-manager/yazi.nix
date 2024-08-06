{ pkgs, ... }: {
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
          run = ''${pkgs.vlc}/bin/vlc "$@"'';
          orphan = true;
        }];

        imager = [{
          run = ''${pkgs.loupe}/bin/loupe "$@"'';
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
