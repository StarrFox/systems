{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      neovim
      git
    ];
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = {
      # TODO: find a better way to handle this
      FLAKE = "/home/starr/systems";
    };
  };
}
