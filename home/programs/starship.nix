_: {
  # NOTE: every shell uses this
  programs.starship = {
    enable = true;
    settings = {
      username.show_always = true;
      nix_shell.heuristic = true;
      hostname.ssh_symbol = "";
      character.success_symbol = "[->](bold green)";
    };
  };
}
