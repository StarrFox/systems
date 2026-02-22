let
  ssh-keys = import ../ssh-keys.nix;
  # users = with ssh-keys; [starr-nixmain];
  # systems = with ssh-keys; [nixmain test_vm nixtop];
  deployment = with ssh-keys; [starr-nixmain nixcell nixcell_root];
in {
  "discord_chan_token.age".publicKeys = deployment;
  "nextcloud_pass.age".publicKeys = deployment;
  "exaroton.age".publicKeys = deployment;
}
