{
  description = "Jakob's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        atlas01 = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs otherPkgs;
            defaultUser = "jakob";
            defaultDescription = "Jakob";
          };
          modules = [
            {
              networking.hostName = "atlas01";
            }
            inputs.disko.nixosModules.disko
            ./configuration/atlas01/configuration.nix
          ];
        };
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
        neptune01 = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs otherPkgs;
            defaultUser = "sysadmin";
            defaultDescription = "Sysadmin";
          };
          modules = [
            {
              networking.hostName = "neptune01";
            }
            ./configuration/neptune01/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        jakob = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };

          modules = [
            inputs.plasma-manager.homeModules.plasma-manager
            ./home/jakob.nix
            {
              home.username = "jakob";
              home.homeDirectory = "/home/jakob";
            }

          ];
        };
      };
    };
}
