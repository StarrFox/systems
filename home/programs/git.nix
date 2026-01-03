{
  pkgs,
  inputs,
  ...
}: let
  starrpkgs = inputs.starrpkgs.packages.${pkgs.stdenv.hostPlatform.system};
in {
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-dash
      starrpkgs.gh-poi
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "StarrFox";
        email = "StarrFox6312@gmail.com";
      };
      push.autoSetupRemote = true;
      pull.rebase = true;
      init.defaultBranch = "main";
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };
    };
  };
}
