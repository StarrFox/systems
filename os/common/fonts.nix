{pkgs, ...}: {
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
    material-icons
  ];
}
