{ mainUser, ... }: {
  services = {
    xserver.displayManager.gdm.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = mainUser;
      };
    };
  };

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
