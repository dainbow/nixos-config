{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    papirus-folders
    papirus-icon-theme
    palenight-theme
  ];

  # System fonts
  fonts.packages = with pkgs; [
    fira-code
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "FiraCode" ]; })
  ];
}
