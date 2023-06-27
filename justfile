# show this list
@default:
    just --list

# switch both os and home
@both: os home

# switch os
@os:
    nh os switch .

# switch home
@home:
    nh home switch .

# check flake
@check:
    nix flake check

# update flake
@update:
    nix flake update

# update flake, check it, and commit
@update-commit: update check
    git commit -am "bump lock"
    git push

# update-command and switch both
@update-switch: update-commit both

# format nix code
@format:
    alejandra .
    deadnix . --edit
    statix fix .

# list current generations
@list-generations:
    # the new nix command for this is: nix profile history --profile /nix/var/nix/profiles/system
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations 

# delete all but the last 2 generations
@delete-generations:
    # the new nix command for this is: sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
    # +2 means keep the last 2 generations
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2

# delete old store paths
@gc:
    nix-collect-garbage -d --delete-older-than 1d

# resource overview
@resources:
    glances

# deploy all nodes
@deploy:
    deploy
