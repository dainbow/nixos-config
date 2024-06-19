{...}: {
    # Zsh config with aliases
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        l = "exa -la";
        c = "clear";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
      };
    };
}
