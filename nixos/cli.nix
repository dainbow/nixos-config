{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    ripunzip
    unrar

    dust

    tldr
    nix-output-monitor

    fastfetch
    onefetch
    nvtopPackages.full
  ];
}
