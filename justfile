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

format:
    alejandra .
    deadnix . --edit
