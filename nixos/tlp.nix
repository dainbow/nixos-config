{ ... }: {
  services.tlp = {
    enable = true;
    settings = {
      CPU_DRIVER_OPMODE_ON_BAT = "passive";
      CPU_DRIVER_OPMODE_ON_AC = "active";

      CPU_SCALING_GOVERNOR_ON_BAT = "conservative";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";

      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC = 1;

      PLATFORM_PROFILE_ON_BAT = "low-power";
      PLATFORM_PROFILE_ON_AC = "balanced";

      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";

      RADEON_DPM_STATE_ON_BAT = "battery";
      RADEON_DPM_STATE_ON_AC = "performance";

      USB_EXCLUDE_BTUSB = 1;
    };
  };
}
