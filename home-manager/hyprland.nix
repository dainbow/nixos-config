{ pkgs, nixosConfig, ... }: {
  services.hyprpaper.enable = true;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  services.mako.enable = true;

  home.packages = with pkgs; [
    grim
    slurp
    satty
    wl-clipboard
    wf-recorder
    killall
    cliphist
    networkmanager_dmenu
    brightnessctl
    playerctl

    xorg.xhost
  ];

  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi -dmenu
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    package = nixosConfig.programs.hyprland.package;

    settings = {
      general = {
        layout = "master";
        gaps_out = 5;
        border_size = 2;
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";

        touchpad = { natural_scroll = true; };
      };

      monitor = ",preferred,auto,1";

      gestures = { workspace_swipe = true; };

      cursor = { no_warps = true; };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };

      decoration = {
        rounding = 10;

        blur = { enabled = false; };

        # drop_shadow = false;
      };

      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "xhost +local:"
      ];

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, killactive"
        "$mod, M, exit"

        "$mod, T, exec, foot"
        "$mod, Y, exec, foot yazi"

        ''
          $mod, P, exec, grim -g "$(slurp -o -r)" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png''

        "$mod, D, exec, rofi -show drun"

        "$mod, B, exec, waybar"
        "$mod SHIFT, B, exec, killall -SIGKILL .waybar-wrapped"

        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, N, exec, networkmanager_dmenu"

        "$mod, L, exec, hyprlock"

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

        ", XF86KbdBrightnessDown, exec, asusctl -p"
        ", XF86KbdBrightnessUp, exec, asusctl -n"

        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"

        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"

        ", XF86AudioStop, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
      ];

      windowrule = [
        "float, ^(Rofi)$"
        "stayfocused, ^(Rofi)$"

        "float, title:^(satty)$"
        "stayfocused, title:^(satty)$"
        "opaque, title:^(satty)$"
      ];

      windowrulev2 = [
        "fullscreen, class:org.telegram.desktop, title:Media viewer"
        "float, class:org.telegram.desktop, title:Media viewer"
      ];
    };
  };
}
