{ lib, pkgs, config, mainUser, ... }: {
  programs = {
    hyprland = { enable = true; };
    hyprlock.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  services.greetd = {
    enable = true;

    settings = rec {
      initial_session = {
        command = "${lib.getExe config.programs.hyprland.package}";
        user = mainUser;
      };

      default_session = initial_session;
    };
  };
}
