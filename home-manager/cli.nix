{ ... }: {
  programs = {
    translate-shell = {
      enable = true;
      settings = {
        hl = "en";
        tl = "ru";
        verbose = true;
      };
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    fd = { enable = true; };

    ripgrep = { enable = true; };

    ripgrep-all = { enable = true; };

    bat = { enable = true; };

    btop = {
      enable = true;
      settings = { update_ms = 1000; };
    };
  };
}
