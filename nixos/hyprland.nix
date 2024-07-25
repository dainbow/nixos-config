{ pkgs, mainUser, ... }: {
  programs.hyprland = { enable = true; };
  programs.hyprlock.enable = true;

  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  services.greetd = {
    enable = true;

    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/hyprland";
        user = mainUser;
      };

      default_session = initial_session;
    };
  };

  security.polkit.enable = true;
}
