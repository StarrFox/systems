{
  inputs,
  lib,
  config,
  pkgs,
  selfpkgs,
  ...
}: {
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-dash
      selfpkgs.gh-poi
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
