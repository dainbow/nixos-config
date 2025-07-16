{ lib, pkgs, ... }: {
  # Zsh config with aliases
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = { enable = true; };

    shellAliases = {
      l = "lla";
      c = "clear";
      cd = "z";
      rebuild = "sudo nixos-rebuild switch |& ${lib.getExe pkgs.nix-output-monitor}";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
  };
}
