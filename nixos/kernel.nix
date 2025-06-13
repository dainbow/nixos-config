{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;

    kernelParams = [ "quiet" "splash" ];
    loader.timeout = 1;
  };
}
