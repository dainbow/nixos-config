{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      open = {
        rules = [
          {
            use = "imager";
            mime = "image/*";
          }
          {
            use = "play";
            mime = "video/*";
          }
          {
            use = "play";
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
      };
    };
  };
}
