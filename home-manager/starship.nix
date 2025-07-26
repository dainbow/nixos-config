{ ... }: {
  # Starship (zsh wrapper) config
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      sudo = { disabled = false; };

      format =
        "$nix_shell$sudo$git_branch$git_commit$git_state$git_status$username$line_break$directory$shell$character";
    };
  };

}
