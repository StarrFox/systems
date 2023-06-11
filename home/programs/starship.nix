_: {
  # NOTE: every shell uses this
  programs.starship = {
    enable = true;
    settings = {
      username.show_always = true;
      nix_shell.heuristic = true;
    };
  };
}
