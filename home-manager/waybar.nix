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
      modules-center = [
        "clock#time"
        "custom/separator"
        "clock#week"
        "custom/separator_dot"
        "clock#month"
        "custom/separator"
        "clock#calendar"
      ];
      modules-right = [
        "hyprland/language"
        "custom/asusctl"
        "network"
        "bluetooth"
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

      "hyprland/language" = {
        format-en = "🇺🇸 ENG (US)";
        format-ru = "🇷🇺 RUS";
      };

      "clock#time" = {
        format = "{:%I:%M:%S %p %Ez}";

        interval = 1;
        tooltip = false;
      };

      "custom/separator" = {
        format = "|";
        tooltip = false;
      };

      "custom/separator_dot" = {
        format = "•";
        tooltip = false;
      };

      "clock#week" = {
        format = "{:%a}";
        tooltip = false;
      };

      "clock#month" = {
        format = "{:%h}";
        tooltip = false;
      };

      "clock#calendar" = {
        format = "{:%F}";
        tooltip = false;
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "󰸈";
        format-icons = { default = [ "" "" "" ]; };
      };

      battery = {
        states = {
          high = 90;
          upper-medium = 70;
          medium = 50;
          lower-medium = 30;
          low = 10;
        };

        format = "{icon} {capacity}% {power}W";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [ "󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];

        interval = refreshInterval;
        tooltip = false;
      };

      cpu = {
        format = "󰻠  {usage}%";

        interval = refreshInterval;
        tooltip = false;
      };

      memory = {
        format = "  {percentage}%";

        interval = refreshInterval;
        tooltip = false;
      };

      tray = {
        # icon-size = 21;
        spacing = 8;
      };

      network = {
        format = "󰤭";
        format-wifi = "{icon}  {essid}";
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-disconnected = "󰤫  Disconnected";

        format-ethernet = "󰈀  {ipaddr}/{cidr}";
        format-linked = "󰈀  {ifname} (No IP)";

        tooltip = false;
        interval = refreshInterval;
      };

      bluetooth = {
        format = "󰂯";
        format-disabled = "󰂲";
        format-connected = "󰂱 {device_alias}";
        format-connected-battery =
          "󰂱 {device_alias} : 󰥉 {device_battery_percentage}%";

        tooltip = false;
        interval = refreshInterval;
      };

      "custom/asusctl" = {
        format = "{}";
        return-type = "json";

        exec = ''
          ${pkgs.bash}/bin/bash ${
            pkgs.writers.writeBash "asusctlScript" ''
              state=$(asusctl profile -p)

              case $state in
                *Quiet*)
                  echo "{\"text\":\"🍃\"}"
                  ;;
                *Balanced*)
                  echo "{\"text\":\"🖕\"}"
                  ;;
                *Performance*)
                  echo "{\"text\":\"🔥\"}"
                  ;;
                *)
                  echo 'zalupa'
                ;;
              esac

              exit 0
            ''
          }
        '';
        on-click = "asusctl profile -n";

        tooltip = false;
        interval = refreshInterval;
      };
    };
  };
}
