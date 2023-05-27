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

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    #packages = let pkgs = nixpkgs.legacyPackages.x86_64-linux; in import ./packages {inherit pkgs;};

    # devshell with formatter
    devShells.x86_64-linux = {
      default = let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
        pkgs.mkShell {
          name = "starr-systems";
          packages = [inputs.alejandra.defaultPackage.x86_64-linux];
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
        };
        modules = [
          ./home/starr.nix
        ];
      };
    };
  };
}
