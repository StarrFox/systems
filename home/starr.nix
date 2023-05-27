{ inputs, lib, config, pkgs, ... }: 
let 
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    config = config.nixpkgs.config;
  };
  starrpkgs = import inputs.starrpkgs {
    system = "${pkgs.system}";
    config = config.nixpkgs.config;
  };
in
{
  imports = [
    ./programs/helix.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/vscode.nix
    ./programs/firefox.nix
    ./services/dunst.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      # TODO: what program uses this? discord? the api thing?
      permittedInsecurePackages = [
        "electron-21.4.0"
      ];
    };
  };

  # NOTE: if switching from plasma consider adding handlr to handle default apps

  home = {
    username = "starr";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "22.11";
    packages = with pkgs; [
      # cli
      bat
      cava
      comma
      croc
      duf
      drawio
      feh
      ffmpeg
      htop
      httpie
      neofetch
      nethogs
      ncdu
      ripgrep
      rsync
      tldr

      # gui
      alacritty
      bitwarden
      #chromium
      discord
      flameshot
      gimp
      ghidra-bin
      insomnia # this is the rest api gui thing
      obsidian
      mpv
      the-powder-toy
      virt-manager
    ] ++ [
      inputs.nh.packages.${pkgs.system}.default
      inputs.nix_search.packages.${pkgs.system}.default
    ] ++ [
      # I want the latest version
      starrpkgs.imhex
    ] ++ [
      python3Packages.ipython
      python3Packages.howdoi
    ] ++ [
      # needed for gpg
      pkgs.pinentry-curses
    ];
  };

  xdg.enable = true;
  xsession.numlock.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  # every shell uses this
  programs.starship = {
    enable = true;
    # we need the latest version for the `heuristic` setting
    package = nixpkgs-unstable.starship;
    settings = {
      username.show_always = true;
      nix_shell.heuristic = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };

  programs.home-manager.enable = true;
}
