# TODO: setup automatic updates with nvfetcher
{ lib
, gcc12Stdenv
, cmake
, llvm
, fetchFromGitHub
, mbedtls
, gtk3
, pkg-config
, capstone
, dbus
, libGLU
, glfw3
, file
, perl
, python3
, jansson
, curl
, fmt_8
, nlohmann_json
, yara
, rsync
}:

let
  version = "1.29.0";

  patterns_src = fetchFromGitHub {
    owner = "WerWolv";
    repo = "ImHex-Patterns";
    rev = "ImHex-v${version}";
    hash = "sha256-lTTXu9RxoD582lXWI789gNcWvJmxmBIlBRIiyY3DseM=";
  };

in
gcc12Stdenv.mkDerivation rec {
  pname = "imhex";
  inherit version;

  src = fetchFromGitHub {
    #fetchSubmodules = true;
    owner = "WerWolv";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-dghyv7rpqGs5dt51ziAaeb/Ba7rGEcJ54AYKRJ2xXuk=";
  };

  nativeBuildInputs = [ cmake llvm python3 perl pkg-config rsync ];

  buildInputs = [
    capstone
    curl
    dbus
    file
    fmt_8
    glfw3
    gtk3
    jansson
    libGLU
    mbedtls
    nlohmann_json
    yara
  ];

  cmakeFlags = [
    "-DIMHEX_OFFLINE_BUILD=ON"
    "-DUSE_SYSTEM_CAPSTONE=ON"
    "-DUSE_SYSTEM_CURL=ON"
    "-DUSE_SYSTEM_FMT=ON"
    "-DUSE_SYSTEM_LLVM=ON"
    "-DUSE_SYSTEM_NLOHMANN_JSON=ON"
    "-DUSE_SYSTEM_YARA=ON"
  ];

  # TODO: rsync can be removed next update because imhex's make doesn't include them by default?
  # rsync is used here so we can not copy the _schema.json files
  postInstall = ''
    mkdir -p $out/share/imhex
    rsync -av --exclude="*_schema.json" ${patterns_src}/{constants,encodings,includes,magic,patterns} $out/share/imhex
  '';

  meta = with lib; {
    description = "Hex Editor for Reverse Engineers, Programmers and people who value their retinas when working at 3 AM";
    homepage = "https://github.com/WerWolv/ImHex";
    license = with licenses; [ gpl2Only ];
  };
}