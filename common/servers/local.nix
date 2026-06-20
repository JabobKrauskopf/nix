{ ... }:

{
  imports = [
    ./default.nix
  ];

  networking.networkmanager.enable = true;
}
