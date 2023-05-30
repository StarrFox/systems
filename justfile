default: both

both: os home

os:
    nh os switch .

home:
    nh home switch .

check:
    nix flake check

update-packages: && format
    nvfetcher --config packages/nvfetcher.toml --build-dir packages/_sources/ 

update: && update-packages
    nix flake update

format:
    alejandra .
    deadnix . --edit

list-generations:
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations 

# +2 means keep the last 2 generations
delete-generations:
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2

gc:
    nix-collect-garbage -d --delete-older-than 1d
