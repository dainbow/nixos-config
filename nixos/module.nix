{ config, pkgs, ... }: {
  imports = [
    ./bootloader.nix
    ./cli.nix
    ./developing.nix
    ./disk-config.nix
    ./fonts_themes.nix
    # ./gdm.nix
    # ./gnome.nix
    ./hardware-configuration.nix
    ./kernel.nix
    ./media.nix
    ./sound.nix
    ./network.nix
    ./terminal.nix
    ./user.nix
    # ./fingerprint.nix
    ./nvidia.nix
    ./stylix.nix
    ./steam.nix
    ./hyprland.nix
    ./bluetooth.nix
    # ./ccache.nix
    ./virtualisation.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    package = pkgs.lix;
  };

  system.switch = {
    enableNg = true;
    enable = false;
  };

  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true;

  # Do not touch
  system.stateVersion = "24.11";
}
