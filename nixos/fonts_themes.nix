{ pkgs, ... }: {
  # System fonts
  fonts.packages = with pkgs; [
    fira-code
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "FiraCode" ]; })
  ];
}
