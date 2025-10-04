{ mainUser, ... }: {
  fileSystems = {
    "/media" = {
      device = "root@192.168.1.1:/mnt/sda1";
      fsType = "sshfs";
      options = [
        "reconnect"
        "ServerAliveInterval=15"
        "x-systemd.automount"
        "_netdev"
        "allow_other"
        "IdentityFile=/home/${mainUser}/.ssh/id_ed25519"
      ];
    };
  };
}
