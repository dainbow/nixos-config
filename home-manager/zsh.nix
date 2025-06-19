{ ... }: {
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
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
  };
}
