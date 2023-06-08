{pkgs, ...}: {
  home.packages = with pkgs; [
    pinentry-curses
  ];

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
}
