{ pkgs, otherPkgs, defaultUser, defaultDescription, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../common-desktop.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${defaultUser} = {
    isNormalUser = true;
    description = defaultDescription;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  environment.systemPackages = with pkgs; with otherPkgs; [
    teamspeak6-client
    element-desktop
    slack
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
