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
      aria2c
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
      vscode
    ] ++ [
      inputs.nh.packages.${pkgs.system}.default
      inputs.nix_search.packages.${pkgs.system}.default
    ] ++ [
      # I want the latest version
      nixpkgs-unstable.imhex
    ] ++ [
      # TODO: update python version sometimes
      python310Packages.ipython
    ];
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      ls = "exa -la";
      download = "aria2c --split=10 ";
      extract = "7z x ";
    };
    # wish they'd just remove this garbage
    interactiveShellInit = "set -U fish_greeting";
  };

  programs.starship = {
    enable = true;
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
