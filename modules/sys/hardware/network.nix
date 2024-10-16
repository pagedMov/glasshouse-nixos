{host, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName =
      if (host == "desktop")
      then "oganesson"
      else "mercury";
    hosts = {
      "192.168.1.163" = ["glasshaus"];
      "192.168.1.111" = ["argon"];
      "192.168.1.223" = ["mercury"];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [30000];
    };
  };
}
