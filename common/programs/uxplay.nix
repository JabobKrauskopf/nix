{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.uxplay ];

  # Avahi for DNS-SD service discovery (required by uxplay)
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  # System-wide uxplay config (specify "fixed ports" for firewall compatibility)
  environment.etc."uxplayrc".text = ''
    p
  '';
  environment.variables.UXPLAYRC = "/etc/uxplayrc";

  # Firewall ports for uxplay -p (legacy ports)
  # TCP 7000, 7001, 7100 and UDP 6000, 6001, 7011
  networking.firewall.allowedTCPPorts = [
    7000
    7001
    7100
  ];
  networking.firewall.allowedUDPPorts = [
    6000
    6001
    7011
  ];
}
