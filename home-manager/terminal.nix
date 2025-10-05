{ ... }: {
  programs = {
    foot = {
      enable = true;
      server.enable = false;
    };
    wezterm = { enable = true; };
  };
}
