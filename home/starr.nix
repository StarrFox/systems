{ inputs, lib, config, pkgs, ... }: 
let 
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    config = config.nixpkgs.config;
  };
in
{
  # imports = [
  #   (import "${home-manager}/nixos")
  # ];

  # TODO: pass (programs.password-store)

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "starr";
    homeDirectory = "/home/starr";
    stateVersion = "22.11";
    packages = with pkgs; [
      # cli
      aria
      bat
      cava
      comma
      croc
      duf
      feh
      ffmpeg
      htop
      httpie
      neofetch
      ncdu
      p7zip
      ripgrep
      tldr

      # gui
      alacritty
      chromium
      mpv
      the-powder-toy
    ] ++ [
      inputs.nh.packages.${pkgs.system}.default
      inputs.nix_search.packages.${pkgs.system}.default
    ] ++ [
      # I want the latest version
      nixpkgs-unstable.imhex
      # erdtree isnt in stable yet
      nixpkgs-unstable.erdtree
    ] ++ [
      # TODO: update python version sometimes
      python310Packages.ipython
    ];
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "exa -la";
      download = "aria2c --split=10";
      extract = "7z x";
      usage = "erd --human";
    };
    # wish they'd just remove this garbage
    interactiveShellInit = "set -U fish_greeting";
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      njpwerner.autodocstring
      bungcip.better-toml
      usernamehw.errorlens
      davidanson.vscode-markdownlint
      jnoortheen.nix-ide
      ms-python.python
      ms-python.vscode-pylance
      mkhl.direnv
    ];
  };

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

  programs.helix = {
    enable = true;
    # the unstable version has a setting I want
    package = nixpkgs-unstable.helix;
    settings = {
      theme = "base16_transparent";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker.hidden = false;
      };
    };
  };

  programs.exa = {
    enable = true;
    extraOptions = [
      "--no-time"
      "--color=always"
      "--group-directories-first"
    ];
  };

  programs.gh.enable = true;
  programs.git = {
    enable = true;
    difftastic.enable = true;
  };
  programs.home-manager.enable = true;
}
