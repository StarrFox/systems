# show this list
@default:
    just --list

# update dc and push the change
@update-dc: && os
    nix flake lock --update-input discord_chan
    git commit -am "update dc"
    git push

# switch os
@os: && update-flatpak
    nh os switch .

# browse dependency tree
@tree:
    # NOTE: home-manager: ~/.nix-profile os: /var/run/current-system
    nix-tree

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

# update-commit, os
@update-switch: update-commit os

# try to update flatpak if it's installed
@update-flatpak:
    which flatpak &> /dev/null && flatpak update -y || true

# update-commit, os, deploy
@full: update-switch deploy

# format nix code
@format:
    alejandra .
    deadnix . --edit
    statix fix .

# list current generations
@list-generations:
    # the new nix command for this is: nix profile history --profile /nix/var/nix/profiles/system
    #sudo nix-env -p /nix/var/nix/profiles/system --list-generations
    nixos-rebuild list-generations

# delete all but the last generation
@delete-generations:
    # the new nix command for this is: sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
    # +2 means keep the last 2 generations
    #sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +1
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

# delete old store paths
@gc:
    nix-collect-garbage -d --delete-older-than 1d

# resource overview
@resources:
    glances

# system info
@info:
    nix shell nixpkgs#{xorg.xdpyinfo,glxinfo,inxi} -c inxi -F

# deploy all nodes
@deploy:
    deploy --skip-checks

# deploy specific node
@deploy_node node:
    deploy --skip-checks .#{{node}}

# delete old generations and gc
@clean: delete-generations gc
