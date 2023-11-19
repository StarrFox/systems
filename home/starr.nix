{config, ...}: {
  imports = [
    ./programs/helix.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/vscode.nix
    ./programs/firefox.nix
    ./programs/gpg.nix
    ./programs/starship.nix
    ./programs/direnv.nix
    ./programs/pass.nix
    ./programs/alacritty.nix
    ./programs/nix-index.nix
    ./programs/home-manager.nix
    #./programs/obs.nix
    ./programs/kakoune.nix
    ./programs/kitty.nix

    ./services/dunst.nix

    ./package_sets/cli.nix
    ./package_sets/gui.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;

      # TODO: remove
      permittedInsecurePackages = [
        "electron-24.8.6"
      ];
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
  xsession.numlock.enable = true;
}
