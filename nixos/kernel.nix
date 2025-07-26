{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;

    kernelParams = [ "quiet" "splash" ];
    loader.timeout = 1;

    kernel.sysctl = { "net.ipv4.ip_default_ttl" = 65; };
  };
}
