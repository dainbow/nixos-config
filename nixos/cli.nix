{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    unzip
    unrar

    simple-mtpfs
    usbutils

    dust

    tldr

    fastfetch
    onefetch
    # nvtopPackages.full
  ];
}
