{ hostname, ... }: {
  networking = {
    hostName = hostname;

    networkmanager.enable = true;

    nameservers = [ "1.1.1.1" ];
    firewall.enable = false;
    resolvconf.dnsExtensionMechanism = false;
  };
}
