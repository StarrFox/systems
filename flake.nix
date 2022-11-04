{
    description = "System configs";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self,  nixpkgs }:
    {
        nixosConfigurations = {
            nixvm = nixpkgs.lib.nixosSystem {
                modules = [ ./configuration.nix ];
            };
        };
    };
}