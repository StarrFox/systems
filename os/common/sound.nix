_: {
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber = {
      enable = true;
      extraConfig = {
        "fix-bluetooth" = {
          # "monitor.bluez.rules" = [
          #   {
          #     matches = [
          #       {
          #         "device.name" = "~bluez_card.*";
          #       }
          #     ];
          #     actions = {
          #       update-props = {
          #         "bluez5.auto-connect" = [ "a2dp_sink" ];
          #         "bluez5.hw-volume" = [ "a2dp_sink" ];
          #       };
          #     };
          #   }
          # ];
          "monitor.bluez.properties" = {
            # "bluez5.roles" = [ "a2dp_sink" ];
            "bluez5.hfphsp-backend" = "none";
          };
        };
      };
    };
  };
}
