{ config, ... }: {
  hardware.nvidia = {
    powerManagement.finegrained = true;
    open = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
