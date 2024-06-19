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
        update =
          "sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
      };
    };
}
