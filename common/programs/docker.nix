{ defaultUser, ... }:

{
  virtualisation.docker.enable = true;
  users.users.${defaultUser}.extraGroups = [ "docker" ];

  networking.firewall.trustedInterfaces = [
    "docker0"
    "br-+"
  ];
}
