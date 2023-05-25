{ inputs, lib, config, pkgs, ... }:
{
  programs.gh.enable = true;

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