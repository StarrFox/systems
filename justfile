default: both

both: os home

os:
    nh os switch .

home:
    nh home switch .

check:
    nix flake check

update:
    nix flake update

update-commit: update check
    git commit -am "bump lock"

update-switch: update-commit both

format:
    alejandra .
    deadnix . --edit
    statix fix .

list-generations:
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations 

# +2 means keep the last 2 generations
delete-generations:
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2

gc:
    nix-collect-garbage -d --delete-older-than 1d
