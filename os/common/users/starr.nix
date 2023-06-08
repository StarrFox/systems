{pkgs, ...}: {
  programs.fish.enable = true;
  services.getty.autologinUser = "starr";
  security.sudo.wheelNeedsPassword = false;
  users.users.starr = {
    isNormalUser = true;
    description = "starr";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "audio" "docker"];
    shell = pkgs.fish;
    initialHashedPassword = "$y$j9T$FF0N8WmrfwlzpN924bHgF/$h6MQqAxuOLe1LiS.1GqOx104aUbwtyho9lnLocm4iq3";
  };
}
