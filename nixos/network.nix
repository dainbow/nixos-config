{ lib, hostname, ... }: {
  networking = {
    hostName = hostname;

    networkmanager = {
      enable = true;
      plugins = lib.mkForce [ ];
    };

    nameservers = [ "1.1.1.1" ];
    firewall.enable = false;
    resolvconf.dnsExtensionMechanism = false;
  };

}
