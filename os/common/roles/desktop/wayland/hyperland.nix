_: {
  imports = [
    ./common.nix
  ];

  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };
}