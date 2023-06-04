{
  inputs,
  config,
  pkgs,
  starrpkgs,
  ...
}: {
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
    ./services/dunst.nix
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
    packages = with pkgs;
      [
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
        thunderbird-bin
        spotify
        virt-manager
      ]
      ++ [
        inputs.nh.packages.${pkgs.system}.default
        inputs.nix_search.packages.${pkgs.system}.default
      ]
      ++ [
        starrpkgs.imhex
      ]
      ++ [
        python3Packages.ipython
        python3Packages.howdoi
      ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  xdg.enable = true;
  xsession.numlock.enable = true;

  programs.home-manager.enable = true;
}
