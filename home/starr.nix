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
      httpie
      neofetch
      chromium
      ripgrep
      vscode
      alacritty
      comma
      duf
      croc
    ] ++ [
      inputs.nh.packages.${pkgs.system}.default
    ];
  };

  programs.fish = {
    enable = true;
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

  programs.gh.enable = true;
  programs.git = {
    enable = true;
    difftastic.enable = true;
  };
  programs.home-manager.enable = true;
}
