{ pkgs, ... }: {
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
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      system-features =
        [ "benchmark" "big-parallel" "kvm" "nixos-test" "gccarch-znver3" ];

      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    package = pkgs.lix;
  };

  # nixpkgs.hostPlatform = {
  #   gcc = {
  #     arch = "znver3";
  #     tune = "znver3";
  #   };

  #   system = "x86_64-linux";
  # };

  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true;

  # Do not touch
  system.stateVersion = "24.11";
}
