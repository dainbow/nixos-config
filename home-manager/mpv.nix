{ pkgs, ... }: {
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      mpris
      uosc
      thumbfast
      sponsorblock
      youtube-upnext
      quality-menu
    ];

    bindings = {
      space = "cycle pause; script-binding uosc/flash-pause-indicator #! Pause";
      right = "seek 5 #! Forward";
      left = "seek -5 #! Back";
      u =
        "script-message-to youtube_upnext menu     #! Youtube Recommendations";
      m = "no-osd cycle mute; script-binding uosc/flash-volume #! Mute";
      up =
        "no-osd add volume  10; script-binding uosc/flash-volume #! Increase volume";
      down =
        "no-osd add volume -10; script-binding uosc/flash-volume #! Decrease volume";
      "[" = "no-osd add speed -0.25; script-binding uosc/flash-speed #! Slower";
      "]" = "no-osd add speed  0.25; script-binding uosc/flash-speed #! Faster";
      ">" =
        "script-binding uosc/next; script-message-to uosc flash-elements top_bar,timeline #! Next";
      "<" =
        "script-binding uosc/prev; script-message-to uosc flash-elements top_bar,timeline #! Prev";
    };

    config = {
      vo = "gpu-next";
      gpu-context = "wayland";
      hwdec = "auto";
      osd-bar = "no";
      cache = "auto";
      video-sync = "display-resample";
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      profile = "fast";
    };
  };
}
