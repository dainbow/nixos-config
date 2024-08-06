{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    ripunzip

    dust

    fastfetch
    onefetch
    nvtopPackages.full
  ];
}
