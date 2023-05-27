{
  description = "nixos configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    starrpkgs.url = "github:StarrFox/nixpkgs/imhex_1.29.0";

    nh.url = "github:ViperML/nh";
    nix_search.url = "github:peterldowns/nix-search-cli";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: rec {
    packages.x86_64-linux = let pkgs = nixpkgs.legacyPackages.x86_64-linux; in import ./packages {inherit pkgs;};

    # devshell with formatter
    devShells.x86_64-linux = {
      default = let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
        pkgs.mkShell {
          name = "starr-systems";
          packages = [
            pkgs.alejandra
            pkgs.just
            inputs.nh.packages.x86_64-linux.default
          ];
        };
    };

    nixosConfigurations = {
      starrnix = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./os/starrnix/default.nix
        ];
      };

      nixtop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./os/nixtop/default.nix
        ];
      };
    };

    homeConfigurations = {
      "starr@starrnix" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          selfpkgs = packages.x86_64-linux;
        };
        modules = [
          ./home/starr.nix
        ];
      };
    };
  };
}
