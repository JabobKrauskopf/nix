{ pkgs, ... }:

{
  imports = [
    ./docker.nix
  ];

  environment.systemPackages = with pkgs; [
    claude-code
  ];
}
