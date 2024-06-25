{ ... }: {
  imports = [
    ./alacritty.nix
    ./btop.nix
    ./dconf.nix
    ./direnv.nix
    ./git.nix
    ./gnome_extensions.nix
    ./gtk.nix
    ./helix.nix
    ./starship.nix
    ./zsh.nix
    ./bat.nix
  ];

  home.stateVersion = "24.11";
}
