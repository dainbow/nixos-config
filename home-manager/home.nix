{ mainUser, ... }: {
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
  ];

  home = {
    username = "${mainUser}";
    homeDirectory = "/home/${mainUser}";
    stateVersion = "24.11";
  };
}
