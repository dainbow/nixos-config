{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    unzip
    unrar

    usbutils
    dust

    (nvtopPackages.amd.override { nvidia = true; })
  ];
}
