{
  description = "Jakob's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    let
      otherPkgs = {
        nixpkgs-unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        charon = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs otherPkgs;
            defaultUser = "sysadmin";
            defaultDescription = "Sysadmin";
          };
          modules = [
            {
              networking.hostName = "charon";
            }
            ./configuration/charon/configuration.nix
          ];
        };
      };
    };
}
