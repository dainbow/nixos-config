{ pkgs, ... }: {
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    image = ./wallpaper.jpg;

    cursor = {
      package = pkgs.hackneyed;
      name = "Hackneyed";
    };

    fonts = {
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 10;
        popups = 10;
      };

      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 0.9;
      desktop = 1.0;
      popups = 0.9;
    };
  };
}
