{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      helix
      git
    ];
    variables = {
      EDITOR = "hx";
    };
    sessionVariables = {
      # TODO: find a better way to handle this
      FLAKE = "/home/starr/systems";
    };
  };

  # we don't need nano since we have helix
  programs.nano.enable = false;
}
