{config, ...}: {
  imports = [
    ./programs/helix.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/kakoune.nix

    ./programs/gpg.nix
    ./programs/starship.nix
    ./programs/direnv.nix
    ./programs/pass.nix

    ./programs/nix-index.nix
    ./programs/home-manager.nix

    ./package_sets/cli.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # NOTE: if switching from plasma consider adding handlr to handle default apps

  home = {
    username = "starr";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.05";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  xdg.enable = true;
}
