{ pkgs, otherPkgs, defaultUser, ... }:

{
  imports =
    [
      ./common.nix
    ];

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; with otherPkgs; [
    kdePackages.kfind
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    kdePackages.ksystemlog
    kdePackages.kcalc
    vlc
    thunderbird
    wl-clipboard
    bitwarden-desktop
    nixpkgs-unstable.vscode
    sourcegit
  ];

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "/home/${defaultUser}/.bitwarden-ssh-agent.sock";
  };

  # Remove once bitwarden is fixed
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
}
