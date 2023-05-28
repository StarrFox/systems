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
    nvfetcher --config packages/nvfetcher.toml --build-dir packages/_sources/

format:
    alejandra .
    deadnix . --edit
