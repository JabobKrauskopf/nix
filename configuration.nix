{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "charon";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.xkb = {
    layout = "eu";
    variant = "";
  };

  users.users.sysadmin = {
    isNormalUser = true;
    description = "Sysadmin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.shellAliases = {
    nix-shell = "echo 'Use `nix shell nixpkgs#hello` instead.'"; # TODO: remove this once muscle memory has been updated
  };

  environment.systemPackages = with pkgs; [
    vim
    htop
    git
    dig
    openssl
  ];

  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  users.users.sysadmin.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHa42I8eXyoYPxrxkH78JrBLwTxmRRTKcqngSJlslln"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOkCxNu7nu3XOHWjm/DpuBN1Ttp1uSKj9nXF/TEpiDGF"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4qr9sHVc0/WXaNHDHcWt7skwv3nWn7GVQiu84iIC8n"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9E2maPZO8DN7jGtW6/m2Djw4zHoTyZmowJBSvm3/nI"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDd5rD/DawdTv/W1tB+A5upZl3b18PpRbDaUKPhVjorl"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1k4B+cwehZLQNaOG8+H1epIqnBCB4bMPc/kbz2Z1su"
  ];
}
