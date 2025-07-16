{ pkgs, lib, config, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = ${lib.getExe config.programs.rofi.package} -dmenu
  '';
}
