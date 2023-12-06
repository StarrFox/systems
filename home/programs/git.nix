{
  pkgs,
  starrpkgs,
  ...
}: {
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-dash
      starrpkgs.gh-poi
    ];
  };

  programs.git = {
    enable = true;
    userName = "StarrFox";
    userEmail = "StarrFox6312@gmail.com";
    delta.enable = true;
    extraConfig = {
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
