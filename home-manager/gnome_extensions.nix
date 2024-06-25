{ pkgs, ... }: {
  # Install gnome extensions for my users
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    dash-to-dock
    just-perfection
    status-area-horizontal-spacing
    vitals
    weather-oclock
  ];
}
