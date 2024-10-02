{ pkgs, ... }: {
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [ mpris mpv-cheatsheet ];

    config = {
      profile = "gpu-hq";
      cache = "auto";
      video-sync = "display-resample";
    };
  };
}
