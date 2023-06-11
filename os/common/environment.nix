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
}
