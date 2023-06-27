let
  ssh-keys = import ../ssh-keys.nix;
  # users = with ssh-keys; [starr-starrnix];
  # systems = with ssh-keys; [starrnix test_vm nixtop];
  deployment = with ssh-keys; [starr-starrnix nixtop];
in {
  "discord_chan_token.age".publicKeys = deployment;
  "arcanumbot_token.age".publicKeys = deployment;
  "attic_creds.age".publicKeys = deployment;
  "nextcloud_pass.age".publicKeys = deployment;
}
