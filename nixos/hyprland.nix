{ pkgs, config, mainUser, ... }: {
  programs.hyprland = { enable = true; };
  programs.hyprlock.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-kde
    ];
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
        command = "${config.programs.hyprland.package}/bin/Hyprland";
        user = mainUser;
      };

      default_session = initial_session;
    };
  };

  security.polkit.enable = true;
}
