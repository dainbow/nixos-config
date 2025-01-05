{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    ripunzip
    unrar

    dust

    tldr
    glow
    nix-output-monitor

    fastfetch
    onefetch
    nvtopPackages.full
  ];
}
