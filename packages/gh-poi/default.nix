{
  buildGoModule,
  source,
}:
buildGoModule rec {
  inherit (source) pname version src vendorSha256;
  doCheck = false;
}
