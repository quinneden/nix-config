{ fetchzip, stdenv, ... }:
stdenv.mkDerivation {
  pname = "operator-mono-nerd-font";
  version = "0.0.0";
  src = fetchzip {
    url = "https://f.qeden.me/m/operator-mono-nerd-font.tgz";
    hash = "sha256-yiw+oYZbwZU5EtjDSlygTGKqDz5rnapNwxjVaDa5zLY=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    dst_opentype=$out/share/fonts/opentype
    find -name \*.otf -exec mkdir -p $dst_opentype \; -exec cp -p {} $dst_opentype \;

    runHook postInstall
  '';
}
