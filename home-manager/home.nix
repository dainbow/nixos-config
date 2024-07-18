{ ... }: {
  imports = [
    ./alacritty.nix
    ./dconf.nix
    ./direnv.nix
    ./git.nix
    ./gnome_extensions.nix
    ./gtk.nix
    ./helix.nix
    ./starship.nix
    ./zsh.nix
    ./cli.nix
    ./qt.nix
  ];

  home.stateVersion = "24.11";
}
