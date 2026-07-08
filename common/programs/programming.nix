{
  otherPkgs,
  ...
}:

{
  imports = [
    ./docker.nix
  ];

  environment.systemPackages = with otherPkgs; [
    nixpkgs-unstable.claude-code
  ];
}
