{
  description = "nixos configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    starrpkgs = {
      url = "github:StarrFox/packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: unlock rev
    nh = {
      url = "github:ViperML/nh/6eed9a053a60a7a806c3866d6b98d1f48e057ca2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix_search = {
      url = "github:peterldowns/nix-search-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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

    discord_chan = {
      url = "github:StarrFox/Discord-chan";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        starrpkgs.follows = "starrpkgs";
      };
    };

    arcanumbot = {
      url = "github:StarrFox/ArcanumBot";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    starrpkgs,
    home-manager,
    agenix,
    discord_chan,
    arcanumbot,
    nix-index-database,
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
            glances
            inputs.nh.packages.x86_64-linux.default
            inputs.agenix.packages.x86_64-linux.default
            deploy-rs.packages.x86_64-linux.default
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
          agenix.nixosModules.default
          discord_chan.nixosModules.default
        ];
      };

      nixtop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./os/nixtop/default.nix
          agenix.nixosModules.default
          discord_chan.nixosModules.default
          arcanumbot.nixosModules.default
        ];
      };
    };

    deploy.nodes.nixtop = {
      hostname = "nixtop";
      profiles = {
        system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixtop;
        };
        home = {
          user = "starr";
          path = deploy-rs.lib.x86_64-linux.activate.home-manager self.homeConfigurations."starr@nixtop";
        };
      };
    };

    checks = builtins.mapAttrs (_system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

    homeConfigurations = let
      spkgs = starrpkgs.packages.x86_64-linux;
    in {
      "starr@starrnix" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          starrpkgs = spkgs;
        };
        modules = [
          ./home/starr.nix
          nix-index-database.hmModules.nix-index
        ];
      };

      "starr@nixtop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          starrpkgs = spkgs;
        };
        modules = [
          ./home/starr_nogui.nix
          nix-index-database.hmModules.nix-index
        ];
      };
    };
  };
}
