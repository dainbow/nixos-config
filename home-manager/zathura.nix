{ ... }: {
  programs.zathura = {
    enable = true;

    extraConfig = ''
      set selection-clipboard clipboard
    '';

    mappings = {
      D = "first-page-column 1:1";
      C-d = "first-page-column 1:2";
    };
  };
}
