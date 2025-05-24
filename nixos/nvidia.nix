{ config, ... }: {
  hardware = {
    nvidia = {
      powerManagement.finegrained = true;
      open = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    # nvidia-container-toolkit = { enable = true; };
  };
}
