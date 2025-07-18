{ lib, pkgs, ... }: {
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
        "custom/weather"
        "custom/separator"
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
        "custom/supergfxctl"
        "network"
        "bluetooth"
        "pulseaudio"
        "battery"
        "cpu"
        "memory"
        "disk"
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
        format = "{icon} {volume}%";
        format-muted = "󰸈";
        format-icons = { default = [ "" "" "" ]; };
        tooltip = false;
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
        format = "CPU {usage}%";

        interval = refreshInterval;
        tooltip = false;
      };

      memory = {
        format = "RAM {percentage}%";

        interval = refreshInterval;
        tooltip = false;
      };

      disk = {
        interval = 5 * refreshInterval;
        format = "DISK {percentage_free}%";
        path = "/";
        tooltip = false;
      };

      tray = {
        # icon-size = 21;
        spacing = 8;
      };

      network = {
        format = "󰤭";
        format-wifi = "{icon} {essid}";
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-disconnected = "󰤫 Disconnected";

        format-ethernet = "󰈀 {ipaddr}/{cidr}";
        format-linked = "󰈀 {ifname} (No IP)";

        tooltip = false;
        interval = refreshInterval;
      };

      bluetooth = {
        format = "󰂯";
        format-disabled = "󰂲";
        format-connected = "󰂱 {device_alias}";
        format-connected-battery = "󰂱 {device_alias}";

        tooltip = false;
        interval = refreshInterval;
      };

      "custom/asusctl" = {
        format = "{}";
        return-type = "json";

        exec = let
          dispatchProfile = pkgs.writeShellScriptBin "dispatchProfile" ''
            state=$(asusctl profile -p)

            case $state in
              *LowPower*)
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
          '';
        in lib.getExe dispatchProfile;
        on-double-click = "asusctl profile -n";

        tooltip = false;
        interval = refreshInterval;
      };
      "custom/weather" = {
        format = "{}";
        tooltip = true;
        interval = 30 * refreshInterval;
        exec = "${lib.getExe pkgs.wttrbar} --location Moscow";
        return-type = "json";
      };
      "custom/supergfxctl" = {
        format = "{}";
        return-type = "json";

        exec = let
          dispatchGPU = pkgs.writeShellScriptBin "dispatchGPU" ''
            state=$(supergfxctl -g)

            case $state in
              *Integrated*)
                echo "{\"text\":\"🔴\"}"
                ;;
              *Hybrid*)
                echo "{\"text\":\"🟢\"}"
                ;;
              *)
                echo 'zalupa'
              ;;
            esac

            exit 0
          '';
        in lib.getExe dispatchGPU;

        on-double-click = let
          dispatchCurve = pkgs.writeShellScriptBin "dispatchCurve" ''
            state=$(supergfxctl -g)

            case $state in
              *Integrated*)
                supergfxctl -m Hybrid
                ;;
              *Hybrid*)
                supergfxctl -m Integrated
                ;;
              *)
                echo 'zalupa'
              ;;
            esac

            exit 0
          '';
        in lib.getExe dispatchCurve;

        tooltip = false;
        interval = refreshInterval;
      };
    };
  };
}
