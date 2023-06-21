let
  ssh-keys = import ../ssh-keys.nix;
  # users = with ssh-keys; [starr-starrnix];
  # systems = with ssh-keys; [starrnix test_vm nixtop];
in {
  "discord_chan_token.age".publicKeys = with ssh-keys; [starr-starrnix nixtop];
  "arcanumbot_token.age".publicKeys = with ssh-keys; [starr-starrnix nixtop];
  "attic_creds.age".publicKeys = with ssh-keys; [starr-starrnix nixtop];
}
