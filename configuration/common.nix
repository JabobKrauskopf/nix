{ config, pkgs, inputs, ... }:

{
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

  users.users.sysadmin.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHa42I8eXyoYPxrxkH78JrBLwTxmRRTKcqngSJlslln"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOkCxNu7nu3XOHWjm/DpuBN1Ttp1uSKj9nXF/TEpiDGF"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4qr9sHVc0/WXaNHDHcWt7skwv3nWn7GVQiu84iIC8n"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9E2maPZO8DN7jGtW6/m2Djw4zHoTyZmowJBSvm3/nI"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDd5rD/DawdTv/W1tB+A5upZl3b18PpRbDaUKPhVjorl"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1k4B+cwehZLQNaOG8+H1epIqnBCB4bMPc/kbz2Z1su"
  ];

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs; # This line technically isn't needed (building the system automatically adds it), but is added for consistency
    nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
  };
}
