{ pkgs, ... }: {
  imports = [
    ./nix-index.nix
    ./terminal.nix
    ./tldr.nix
    # ./dconf.nix
    ./direnv.nix
    ./git.nix
    # ./gnome_extensions.nix
    # ./gtk.nix
    ./helix.nix
    ./starship.nix
    ./zsh.nix
    ./cli.nix
    ./yazi.nix
    ./qt.nix
    ./firefox.nix
    ./chromium.nix
    ./hyprland.nix
    ./rofi.nix
    ./mako.nix
    ./hyprlock.nix
    ./waybar.nix
    # ./vscode.nix
    ./mpv.nix
    ./bluetooth.nix
    ./zathura.nix
  ];

  home.stateVersion = "24.11";
}
