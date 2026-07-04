{ defaultUser, ... }:

{
  virtualisation.docker.enable = true;
  users.users.${defaultUser}.extraGroups = [ "docker" ];

  networking.firewall.trustedInterfaces = [
    "docker0"
    "br-+"
  ];

  virtualisation.docker.daemon.settings = {
    default-address-pools = [
      {
        base = "172.16.0.0/12";
        size = 24;
      }
    ];
  };
}
