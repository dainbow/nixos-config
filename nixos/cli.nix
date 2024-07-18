{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    ripunzip

    dust

    fastfetch
    nvtopPackages.full
  ];
}
