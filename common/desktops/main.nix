{
  pkgs,
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
  ];

  environment.systemPackages = with pkgs; [
    teamspeak6-client
    element-desktop
    slack
    proton-vpn
  ];
}
