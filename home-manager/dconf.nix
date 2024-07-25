{ lib, ... }: {
  # Dconf settings
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      # Enable extensions I use
      enabled-extensions = [
        "Vitals@CoreCoding.com"
        "just-perfection-desktop@just-perfection"
        "blur-my-shell@aunetx"
        "appindicatorsupport@rgcjonas.gmail.com"
        "weatheroclock@CleoMenezesJr.github.io"
        "dash-to-dock@micxgx.gmail.com"
      ];
      # Pined dock apps
      favorite-apps = [
        "thorium-browser.desktop"
        "org.telegram.desktop.desktop"
        "code.desktop"
        "transmission-gtk.desktop"
        "org.codeberg.dnkl.foot.desktop"
      ];
    };
    # Common settings (dark mode, battery, seconds)
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
      clock-show-seconds = true;
    };
    # Keyboard layouts
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "ru" ]) ];
    };
    # Override default alt-tab behaviour
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };
    # Custom shortcut for terminal
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Super>t";
        command = "foot";
        name = "Term";
      };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
      {
        binding = "<Super>y";
        command = "foot yazi";
        name = "Explorer";
      };
    # Vitals (system info) extension config
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [
        "_memory_usage_"
        "__network-rx_max__"
        "_battery_rate_"
        "_processor_usage_"
      ];
      show-storage = true;
      show-voltage = true;
      show-memory = true;
      show-fan = false;
      show-temperature = false;
      show-processor = true;
      show-network = true;
      show-battery = true;
    };
    # Weather config
    "org/gnome/shell/weather" = { automatic-location = true; };
    "org/gnome/GWeather4" = { temperature-unit = "centigrade"; };
  };
}
