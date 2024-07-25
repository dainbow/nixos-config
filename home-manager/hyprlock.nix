{ config, ... }: {
  programs.hyprlock = {
    enable = true;

    settings = let
      rgb = color: "rgb(${color})";
      rgba = color: alpha: "rgba(${color}${alpha})";
      colors = config.lib.stylix.colors;
      font = config.stylix.fonts;
    in {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = {
        monitor = "";
        path = "${config.stylix.image}";
        blur_passes = 2;
        color = "${rgb colors.base00}";
      };

      label = [
        {
          monitor = "";
          text = ''cmd[update:30000] echo "$(date +"%R")'';
          color = "${rgb colors.base05}";
          font_size = 90;
          font_family = "${font.monospace.name}";
          position = "-130, -100";
          hailign = "right";
          valign = "top";
          shadow_passes = 2;
        }

        {
          monitor = "";
          text = ''cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"'';
          color = "${rgb colors.base05}";
          font_size = 25;
          font_family = "${font.monospace.name}";
          position = "-130, -250";
          halign = "right";
          valign = "top";
          shadow_passes = 2;
        }

        {
          monitor = "";
          text = "$LAYOUT";
          color = "${rgb colors.base05}";
          font_size = 20;
          font_family = "${font.monospace.name}";
          position = "-130, -310";
          halign = "right";
          valign = "top";
          shadow_passes = 2;
        }
      ];

      input-field = {
        monitor = "";
        size = "400, 70";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "${rgba colors.base0C "b3"}";
        inner_color = "${rgb colors.base02}";
        font_color = "${rgb colors.base05}";
        fade_on_empty = false;
        placeholder_text = ''
          <span foreground="##${colors.base05}"><i>󰌾 Logged in as </i><span foreground="##${colors.base0C}">$USER</span></span>'';
        hide_input = false;
        check_color = "${rgba colors.base0C "b3"}";
        fail_color = "${rgb colors.base08}";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "${rgb colors.base0A}";
        position = "0, -185";
        halign = "center";
        valign = "center";
        shadow_passes = 2;
      };
    };
  };
}
