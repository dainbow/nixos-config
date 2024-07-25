{ pkgs, ... }: {
  programs.waybar = {
    enable = true;

    settings.mainBar = let refreshInterval = 2;
    in {
      height = 34;
      layer = "top";
      mode = "dock";
      position = "top";
      spacing = 4;
      start_hidden = false;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ 
        "hyprland/language" 
        "pulseaudio" 
        "battery" 
        "cpu" 
        "memory" 
        "tray" 
      ];

      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";

        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
      };

      "hyprland/language" = { tooltip = false; };

      clock = {
        interval = 1;
        format = "{:%c}";
      };

      pulseaudio = {
        format = "{volume}% {icon}";
        format-muted = "󰸈";
        format-icons = { default = [ "" "" "" ]; };
      };

      battery = {
        states = {
          good = 60;
          warning = 40;
          critical = 10;
        };
        format = "{capacity}% {icon} {power}W";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        format-icons = [ "󰂎" "󱊡" "󱊢" "󱊣" "󱊣" ];
        interval = refreshInterval;
      };

      cpu = {
        format = "{usage}% ({load})";
        interval = refreshInterval;
        tooltip = false;
      };

      memory = {
        format = "{percentage}% 💾";
        interval = refreshInterval;
      };

      tray = {
        # icon-size = 21;
        spacing = 8;
      };
    };
  };
}
