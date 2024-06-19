{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    ripunzip

    fd
    ripgrep
    dust
    eza
    bat

    btop
    fastfetch
    nvtopPackages.full
  ];
}
