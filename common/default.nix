{
  pkgs,
  inputs,
  defaultUser,
  defaultDescription,
  ...
}:

{
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

  users.users.${defaultUser} = {
    isNormalUser = true;
    description = defaultDescription;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  environment.shellAliases = {
    nix-shell = "echo 'Use `nix shell nixpkgs#hello` instead.'"; # TODO: remove this once muscle memory has been updated
  };

  environment.systemPackages = with pkgs; [
    vim
    htop
    git
    dig
    openssl
    nixd
    nixfmt
    jq
    ncdu
    dysk
    gnumake
  ];

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs; # This line technically isn't needed (building the system automatically adds it), but is added for consistency
    nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  users.defaultUserShell = pkgs.fish;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GiB, in MiB
    }
  ];
}
