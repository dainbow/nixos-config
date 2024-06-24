{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    ripunzip

    fd
    ripgrep
    dust
    eza
    bat
    glow

    btop
    fastfetch
    nvtopPackages.full
  ];
}
