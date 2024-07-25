{ config, ... }: {
  hardware.nvidia = {
    powerManagement.finegrained = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
