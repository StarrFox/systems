{
  description = "nixos configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    starrpkgs = {
      url = "github:StarrFox/packages";
      inputs = {
        flake-parts.follows = "flake-parts";
      };
    };
    discord_chan = {
      url = "github:StarrFox/Discord-chan";
      inputs = {
        flake-parts.follows = "flake-parts";
      };
    };
    nix_search = {
      url = "github:peterldowns/nix-search-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: should be the same release version as nixpkgs version
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-nixcord.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    discord_chan,
    deploy-rs,
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
            btop
            nix-tree
            nh

            # disambiguate from the function argument
            pkgs.deploy-rs

            inputs.agenix.packages.x86_64-linux.default
            #deploy-rs.packages.x86_64-linux.default
          ];
        };
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
      nixmain = mkNixosConfig {
        extraModules = [./os/nixmain/default.nix];
      };

      nixtest = mkNixosConfig {
        extraModules = [./os/nixtest/default.nix];
      };

      # nixtop = mkNixosConfig {
      #   extraModules = [
      #     ./os/nixtop/default.nix
      #     discord_chan.nixosModules.default
      #   ];
      #   enableGui = false;
      # };

      nixarr = mkNixosConfig {
        extraModules = [
          ./os/nixarr/default.nix
          {
            home-manager.users.starr.home.file."justfile".source = ./misc/nixarr_justfile;
          }
        ];
        enableGui = false;
      };

      nixcell = mkNixosConfig {
        extraModules = [
          ./os/nixcell/default.nix
          discord_chan.nixosModules.default
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
        nixcell = {
          hostname = "nixcell";
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixcell;
            };
          };
        };

        # nixtop = {
        #   hostname = "nixtop";
        #   profiles = {
        #     system = {
        #       user = "root";
        #       path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixtop;
        #     };
        #   };
        # };

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
