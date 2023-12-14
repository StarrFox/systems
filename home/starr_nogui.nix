{config, inputs, ...}: {
  imports = [
    ./programs/helix.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/kakoune.nix

    ./programs/gpg.nix
    ./programs/starship.nix
    ./programs/direnv.nix
    ./programs/poetry.nix
    ./programs/zoxide.nix

    ./programs/nix-index.nix
    ./programs/home-manager.nix

    ./package_sets/cli.nix

    inputs.nix-index-database.hmModules.nix-index
  ];

  # NOTE: if switching from plasma consider adding handlr to handle default apps

  home = {
    username = "starr";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  xdg.enable = true;
}
