{ lib, pkgs, ... }: {
  services.tlp = {
    enable = true;
    settings = {
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      CPU_DRIVER_OPMODE_ON_AC = "active";

      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC = 1;

      PLATFORM_PROFILE_ON_BAT = "low-power";
      PLATFORM_PROFILE_ON_AC = "balanced";

      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";

      RADEON_DPM_STATE_ON_BAT = "battery";
      RADEON_DPM_STATE_ON_AC = "balanced";

      USB_EXCLUDE_BTUSB = 1;

      RUNTIME_PM_ON_AC = "auto";

      STOP_CHARGE_THRESH_BAT0 = "70";
    };
  };
  services.udev.extraRules = let
    supergfxBin = lib.getExe' pkgs.supergfxctl "supergfxctl";
    toMode = mode:
      pkgs.writeShellScriptBin "to${mode}" ''
        if [[ $(${supergfxBin} -g) != ${mode} ]]; then
          ${supergfxBin} -m ${mode}
          ${lib.getExe' pkgs.systemd "systemctl"} restart greetd.service
        fi
      '';
  in ''
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="${
      lib.getExe (toMode "Hybrid")
    }"
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${
      lib.getExe (toMode "Integrated")
    }"
  '';
}

