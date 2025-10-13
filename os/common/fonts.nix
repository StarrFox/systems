{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    material-icons
  ];
}
