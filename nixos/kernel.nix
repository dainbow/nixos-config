{ pkgs, lib, ... }:
let packages = pkgs.linuxPackages_cachyos-gcc;
in {
  boot = {
    kernelPackages = packages;

    kernelParams = [ "quiet" "splash" ];
    loader.timeout = 1;

    kernel.sysctl = { "net.ipv4.ip_default_ttl" = 65; };
  };

  system.modulesTree = [ (lib.getOutput "modules" packages.kernel) ];
}
