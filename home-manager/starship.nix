{ ... }: {
  # Starship (zsh wrapper) config
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      sudo = { disabled = false; };

      memory_usage = {
        disabled = false;
        threshold = 50;
      };

      os = { disabled = false; };
    };
  };

}
