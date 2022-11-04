{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
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
