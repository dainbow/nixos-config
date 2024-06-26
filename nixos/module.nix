{ ... }: {
  imports = [
    ./bootloader.nix
    ./btrfs.nix
    ./cli.nix
    ./developing.nix
    ./disk-config.nix
    ./fonts_themes.nix
    ./gdm.nix
    ./gnome.nix
    ./hardware-configuration.nix
    ./kernel.nix
    ./media.nix
    ./sound.nix
    ./network.nix
    ./terminal.nix
    ./user.nix
    ./fingerprint.nix
    ./nvidia.nix
    ./stylix.nix
    ./steam.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true;

  # Do not touch
  system.stateVersion = "24.11";
}
