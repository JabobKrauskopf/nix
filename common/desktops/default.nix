{
  pkgs,
  otherPkgs,
  defaultUser,
  ...
}:

{
  imports = [
    ../default.nix
    ../programs/firefox.nix
  ];

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  services.fwupd.enable = true;

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true; # Needed for printing (and being able to resolves names in the `.local` domain)
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  environment.systemPackages =
    with pkgs;
    with otherPkgs;
    [
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
      home-manager
    ];

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "/home/${defaultUser}/.bitwarden-ssh-agent.sock";
  };

  # Remove once bitwarden is fixed
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  environment.etc = {
    "xdg/kcminputrc".text = ''
      # Mouse & Touchpad > (mouse) > Acceleration profile: None/Flat (applies to all mice)
      [Libinput][Defaults][Pointer][$i]
      PointerAccelerationProfile=1

      # Keyboard > NumLock on startup: Turn on
      [Keyboard][$i]
      NumLock=0
    '';
  };
}
