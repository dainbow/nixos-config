{ pkgs, ... }: {
  # Zsh config with aliases
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = { enable = true; };

    shellAliases = {
      l = "exa -la --icons";
      c = "clear";
      record =
        ''${pkgs.wf-recorder}/bin/wf-recorder -g "$(${pkgs.slurp}/bin/slurp)"'';
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
  };
}
