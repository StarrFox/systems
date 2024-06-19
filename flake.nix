{
  description = "nixos configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-23.11";
    starrpkgs.url = "github:StarrFox/packages";
    nh.url = "github:ViperML/nh";
    discord_chan.url = "github:StarrFox/Discord-chan";
    arcanumbot.url = "github:StarrFox/ArcanumBot";

    nix_search = {
      url = "github:peterldowns/nix-search-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: should be the same release version as nixpkgs version
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        # remove for darwin support
        darwin.follows = "";
      };
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    discord_chan,
    arcanumbot,
    deploy-rs,
    nixos-generators,
    ...
  } @ inputs: {
    devShells.x86_64-linux = {
      default = let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
        pkgs.mkShell {
          name = "starr-systems";
          packages = with pkgs; [
            alejandra
            deadnix
            just
            nil
            statix
            glances
            nix-tree

            inputs.nh.packages.x86_64-linux.default
            inputs.agenix.packages.x86_64-linux.default
            deploy-rs.packages.x86_64-linux.default
          ];
        };
    };

    packages.x86_64-linux.vm = nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      # for some reason this doesn't take a nixosconfig
      inherit (self.nixosConfigurations.starrnix._module.args) modules;
      inherit (self.nixosConfigurations.starrnix._module) specialArgs;
      format = "vm";
    };

    nixosConfigurations = let
      mkNixosConfig = {
        extraModules ? [],
        enableGui ? true,
      }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules =
            [
              agenix.nixosModules.default
              home-manager.nixosModules.default
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.starr = import ./home/starr.nix {guiEnabled = enableGui;};

                home-manager.extraSpecialArgs = {inherit inputs;};
              }
              {
                system.configurationRevision = self.rev or "dirty";
              }
            ]
            ++ extraModules;
        };
    in {
      starrnix = mkNixosConfig {
        extraModules = [./os/starrnix/default.nix];
      };

      starrtest = mkNixosConfig {
        extraModules = [./os/starrtest/default.nix];
      };

      nixtop = mkNixosConfig {
        extraModules = [
          ./os/nixtop/default.nix
          discord_chan.nixosModules.default
          arcanumbot.nixosModules.default
        ];
        enableGui = false;
      };

      nixarr = mkNixosConfig {
        extraModules = [
          ./os/nixarr/default.nix
          ./misc/flood_module.nix
          {
            home-manager.users.starr.home.file."justfile".source = ./misc/nixarr_justfile;
          }
        ];
        enableGui = false;
      };
    };

    deploy = {
      # this is too slow
      #fastConnection = true;
      # these currently break too often (networkmanager-online)
      autoRollback = false;
      magicRollback = false;

      nodes = {
        nixtop = {
          hostname = "nixtop";
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixtop;
            };
          };
        };

        nixarr = {
          hostname = "nixarr";
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixarr;
            };
          };
        };
      };
    };

    checks = builtins.mapAttrs (_system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
