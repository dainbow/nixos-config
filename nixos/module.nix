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
    # ./steam.nix
    ./hyprland.nix
    ./bluetooth.nix
    # ./ccache.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    package = pkgs.lix;
  };

  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true;

  # Do not touch
  system.stateVersion = "24.11";
}
