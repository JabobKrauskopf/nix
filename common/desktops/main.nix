{
  pkgs,
  otherPkgs,
  ...
}:

{
  imports = [
    ./default.nix
    ../programs/nvidia.nix
    ../programs/steam.nix
    ../programs/programming.nix
    ../programs/uxplay.nix
    ../programs/jellyfin.nix
    ../programs/spotify.nix
    ../programs/fluxer
    ../programs/bambu-studio.nix
  ];

  environment.systemPackages =
    with pkgs;
    with otherPkgs;
    [
      nixpkgs-unstable.teamspeak6-client
      element-desktop
      signal-desktop
      slack
      proton-vpn
      nixpkgs-unstable.yaak
      nixpkgs-unstable.rustdesk-flutter
    ];
}
