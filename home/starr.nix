{guiEnabled ? false}: {
  config,
  inputs,
  ...
}: let
  extraModules = if guiEnabled then [
    ./programs/vscode.nix
    ./programs/firefox.nix
    ./programs/alacritty.nix
    ./programs/kitty.nix
    ./programs/wezterm
    #./programs/rio.nix
    ./services/dunst.nix
    ./programs/vscode.nix
    #./programs/obs.nix
    ./package_sets/gui.nix
  ] else [];
in {
  imports = [
    ./programs/helix.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/starship.nix
    ./programs/direnv.nix
    ./programs/nix-index.nix
    #./programs/home-manager.nix
    ./programs/kakoune.nix
    ./programs/poetry.nix
    ./programs/zoxide.nix

    ./package_sets/cli.nix

    # TODO: use nixos module instead
    inputs.nix-index-database.hmModules.nix-index
  ] ++ extraModules;

  # NOTE: if switching from plasma consider adding handlr to handle default apps

  home = {
    username = "starr";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  xdg.enable = true;
  xsession.numlock.enable = if guiEnabled then true else false;
}
