{pkgs, lib, ...}: {
  environment = {
    systemPackages = with pkgs; [
      helix
      git
    ];
    # set when shell is opened
    variables = {
      EDITOR = lib.getExe pkgs.helix;
    };
    # set during login
    sessionVariables = {
      # TODO: find a better way to handle this
      NH_FLAKE = "/home/starr/systems";
    };
  };

  # we don't need nano since we have helix
  programs.nano.enable = false;
}
