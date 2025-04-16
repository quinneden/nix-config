{ stdenv, fetchurl, ... }:

stdenv.mkDerivation (finalAttrs: {
  pname = "palera1n";
  version = "2.1-beta.1";

  src = fetchurl {
    url = "https://github.com/${finalAttrs.pname}/${finalAttrs.pname}/releases/download/v${finalAttrs.version}/${finalAttrs.pname}-macos-arm64";
    hash = "sha256-hRoCAaTwpoza2RnWNtDPSbOHJwhiuHh+5KTXWxUbfhM=";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    install -Dm 755 $src "$out/bin/palera1n"
    runHook postInstall
  '';
})
