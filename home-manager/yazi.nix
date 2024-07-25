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
          exec = ''${pkgs.vlc}/bin/vlc "$@"'';
          orphan = true;
        }];

        imager = [{
          exec = ''${pkgs.loupe}/bin/loupe "$@"'';
          orhan = true;
        }];

        copy = [{
          exec = ''wl-copy < "$@"'';
          orhan = true;
        }];
      };
    };
  };
}
