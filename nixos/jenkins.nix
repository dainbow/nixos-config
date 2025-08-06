{ config, ... }: {
  services.jenkins = {
    enable = true;
    extraJavaOptions = [ "-Djenkins.install.runSetupWizard=false" ];
  };

  systemd.services.jenkins-config = let cfg = config.services.jenkins;
  in {
    before = [ "jenkins.service" ];

    serviceConfig = {
      User = cfg.user;
      Type = "oneshot";
    };

    script = ''
      echo "zalupa" > "${cfg.home}/zalupa"
    '';

    wantedBy = [ "jenkins.service" ];
  };
}
