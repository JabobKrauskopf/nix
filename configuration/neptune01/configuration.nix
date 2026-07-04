{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/servers/local.nix
    ../../common/programs/nvidia.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/nasa" = {
    device = "/dev/disk/by-uuid/6182822f-8ab1-42c6-a2b5-3a2cede0b433";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  systemd.services.docker.unitConfig.RequiresMountsFor = "/nasa";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
