{ pkgs, ... }: {
  imports = [
    ./overlays.nix
    ./yubikey.nix
    ./bootloader.nix
    ./cli.nix
    ./disk-config.nix
    ./fonts_themes.nix
    ./hardware-configuration.nix
    ./kernel.nix
    ./media.nix
    ./sound.nix
    ./network.nix
    ./terminal.nix
    ./user.nix
    ./nvidia.nix
    ./stylix.nix
    ./hyprland.nix
    ./bluetooth.nix
    ./tlp.nix
    ./mounts.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
    rocmSupport = true;
  };

  # Do not touch
  system.stateVersion = "24.11";
}
