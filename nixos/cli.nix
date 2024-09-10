{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    ripunzip

    dust

    tldr
    nix-output-monitor

    fastfetch
    onefetch
    nvtopPackages.full
  ];
}
