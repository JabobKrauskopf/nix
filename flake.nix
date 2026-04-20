{
  description = "Jakob's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    {
      nixosConfigurations = {
        charon = inputs.nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration/charon/configuration.nix
          ];
        };
      };
    };
}
