default: both

both: os home

os:
    nh os switch .

home:
    nh home switch .

check:
    nix flake check

update-packages: && format
    nvfetcher --config packages/nvfetcher.toml --build-dir packages/_sources/ --commit-changes

update: && update-packages
    nix flake update

format:
    alejandra .
    deadnix . --edit
