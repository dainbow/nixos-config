{ pkgs, ... }: {
  services.hyprpaper.enable = true;
  programs.rofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      general = { layout = "master"; };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";

        touchpad = { natural_scroll = true; };
      };

      monitor = ",preferred,auto,1";

      gestures = { workspace_swipe = true; };

      cursor = { no_warps = true; };

      exec-once = [
        "${pkgs.polkit-kde-agent}/libexec/.polkit-kde-authentication-agent-1-wrapped"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, killactive"
        "$mod, M, exit"

        "$mod, T, exec, foot"
        "$mod, Y, exec, foot yazi"

        ''$mod, P, exec, grim -g "$(slurp -o -r)" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png''

        "$mod, D, exec, rofi -show drun"

        "$mod, B, exec, waybar"
        "$mod SHIFT, B, exec, killall -SIGUSR1 .waybar-wrapped"

        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, left, swapwindow, l"
        "$mod SHIFT, right, swapwindow, r"
        "$mod SHIFT, up, swapwindow, u"
        "$mod SHIFT, down, swapwindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"
        "$mod SHIFT, 0, movetoworkspacesilent, 10"

        "$mod CTRL, left, resizeactive, -60 0"
        "$mod CTRL, right, resizeactive, 60 0"
        "$mod CTRL, up, resizeactive, 0 -60"
        "$mod CTRL, down, resizeactive, 0 60"
      
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"        
      ];

      windowrule = [ 
        "float, ^(Rofi)$" 
        "stayfocused, ^(Rofi)$"
        
        "float, title:^(Media viewer)$" 
      
        "float, title:^(satty)$"
        "stayfocused, title:^(satty)$"
        "opaque, title:^(satty)$"    
      ];
    };
  };
}
