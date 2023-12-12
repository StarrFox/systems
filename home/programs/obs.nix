{pkgs, ...}: {
  # TODO: use home-manager.sharedModule in os obs module
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-pipewire-audio-capture
      input-overlay
    ];
  };
}
