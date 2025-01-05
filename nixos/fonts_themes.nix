{ pkgs, ... }: {
  # System fonts
  fonts.packages = with pkgs; [
    fira-code

    nerd-fonts.symbols-only
    nerd-fonts.fira-code
  ];
}
