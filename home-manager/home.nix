{ ... }: {
  imports = [
    ./terminal.nix
    # ./dconf.nix
    ./direnv.nix
    ./git.nix
    # ./gnome_extensions.nix
    ./gtk.nix
    ./helix.nix
    ./starship.nix
    ./zsh.nix
    ./cli.nix
    ./yazi.nix
    ./qt.nix
    ./firefox.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./waybar.nix
    ./vscode.nix
    ./mpv.nix
    ./bluetooth.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.11";
}
