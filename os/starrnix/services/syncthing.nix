{...}:
{
  # TODO: setup declaritivly
  # NOTE: gui is on 8384
  services.syncthing = {
    enable = true;
    overrideFolders = false;
    overrideDevices = false;
    openDefaultPorts = true;
    user = "starr";
    group = "users";
    # NOTE: this chowns this dir to .user
    dataDir = "/home/starr";
  };
}