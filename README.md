# systems

## self docs

### adding new devices

1. add the hardware configuration to devices/\<device name>.nix

2. optionally add the public key to secrets/secrets.nix

3. change [this line](https://github.com/StarrFox/systems/blob/1e193a69551e12c8c4939eebec871f6ed0f6ed7e/os/starrnix/default.nix#L16) to reference the new device

### Secrets

Edit a secret (or create a new one)

```bash
cd secrets
agenix -e file.age
```

rekey secrets (if adding new recepiants)

```bash
cd secrets
agenix --rekey
```

## Resources

### Info sources

[NixOS search](https://search.nixos.org/): allows searching packages and options

[Home manager option search](https://mipmip.github.io/home-manager-option-search/): search home manager options

[Noogle](https://noogle.dev/): search nix functions

[Nixtracker](https://nixtracker.org/): track nix pr status

### changelogs

[NixOS](https://nixos.org/manual/nixos/stable/release-notes.html)

[Home Manager](https://nix-community.github.io/home-manager/release-notes.html)

### links

[NixOS manual](https://nixos.org/manual/nixos/stable/)

[Nix command reference](https://nixos.org/manual/nix/stable/command-ref/experimental-commands.html)

[Tour of nix](https://nixcloud.io/tour/?id=1)

[Nix Pills](https://nixos.org/guides/nix-pills/)

[Nixpkgs](https://github.com/NixOS/nixpkgs)

### other configs

[starter configs](https://github.com/Misterio77/nix-starter-configs): used a lot to start configs

[viperML's configs](https://github.com/viperML/dotfiles)

[Stu's configs](https://github.com/Stupremee/nix)

[Remi's configs](https://github.com/remi-gelinas/rosetta/)
