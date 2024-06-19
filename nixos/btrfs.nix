{ ... }: {
  # Btrfs stuff
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";
}
