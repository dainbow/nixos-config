{ pkgs, lib, config, ... }: {
  home.packages = with pkgs; [ papirus-icon-theme ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
    };
  };

  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = ${lib.getExe config.programs.rofi.package} -dmenu
  '';
}

