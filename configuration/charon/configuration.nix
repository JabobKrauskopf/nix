{ config, pkgs, otherPkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../common.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  users.users.sysadmin = {
    isNormalUser = true;
    description = "Sysadmin";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs otherPkgs; [];

  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  virtualisation.docker.enable = true;
}
