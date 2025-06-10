{ config, ... }: {
  hardware = {
    nvidia = {
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      open = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    # nvidia-container-toolkit = { enable = true; };
  };
}
