{ inputs, lib, config, pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-dash
    ];
  };

  programs.git = {
    enable = true;
    userName = "StarrFox";
    userEmail = "StarrFox6312@gmail.com";
    delta.enable = true;
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };
}