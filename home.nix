{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
      url = "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
      sha256 = "sha256:03ry8wyi22b0ml4dg1vjg0xrahv9x0qsxhz01b720a4qcw9c72nr";
    };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.starr = {
    home.packages = [
      pkgs.httpie
      pkgs.neofetch
      pkgs.chromium
    ];

    programs.direnv = {
	enable = true;
	nix-direnv.enable = true; 
    };


    programs.alacritty.enable = true;
    programs.starship.enable = true;
    programs.home-manager.enable = true;

    home.file = {
      ".config/fish/config.fish" = {
        text = ''
	set fish_greeting

	abbr nix-shell "nix-shell --command fish"

	starship init fish | source

	direnv hook fish | source
	'';
      };
    };

  };
}
