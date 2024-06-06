_: {
  #services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Disable = "Handsfree";
      };
    };
  };

  hardware.pulseaudio.extraConfig = ''
  .ifexists module-bluetooth-policy.so
  load-module module-bluetooth-policy auto_switch=false  # <---- !
  .endif
  '';
}
