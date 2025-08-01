{ stdenv, fetchzip, ... }:

stdenv.mkDerivation {
  name = "micro-colors";

  src = fetchzip {
    url = "https://f.qeden.me/m/micro-colors.tgz";
    hash = "sha256-ZbuQvSBMTJs7yblJNQwU0LAdLiqIvmB7uMpwHZE9n8I=";
    stripRoot = false;
  };

  installPhase = ''
    install -Dm644 -t $out $src/*
  '';
}
