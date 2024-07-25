{ pkgs, ... }: {
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fd = { enable = true; };

  programs.ripgrep = { enable = true; };

  programs.bat = { enable = true; };

  programs.btop = { enable = true; };
}
