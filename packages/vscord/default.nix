{
  pkgs,
  source,
  ...
}: {
  vscord = pkgs.vscode-utils.buildVscodeExtension rec {
    inherit (source) pname version src;
    name = pname;
    vscodeExtUniqueId = "LeonardSSH.vscord";
  };
}
