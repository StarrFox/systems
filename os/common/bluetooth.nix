# {inputs, pkgs, config, ...}: let
#   nixpkgs-old = import inputs.nixpkgs-old {
#     system = "${pkgs.system}";
#     inherit (config.nixpkgs) config;
#   };
# in
_: {
  #services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    #package = nixpkgs-old.bluez;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Disable = "Handsfree";
      };
    };
  };

  services.pulseaudio.extraConfig = ''
  .ifexists module-bluetooth-policy.so
  load-module module-bluetooth-policy auto_switch=false
  .endif
  '';
}
