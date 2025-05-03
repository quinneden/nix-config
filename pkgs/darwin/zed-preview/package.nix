{
  _7zz,
  fetchurl,
  stdenv,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "zed-preview";
  version = "0.185.4-pre";
  src = fetchurl {
    url = "https://github.com/zed-industries/zed/releases/download/v${finalAttrs.version}/Zed-aarch64.dmg";
    hash = "sha256-BTfx+jbkKENdLCztb7g3zAZ+qJ+eid2EfDbgjdKUqVA=";
  };

  nativeBuildInputs = [ _7zz ];

  unpackPhase = ''
    runHook preBuild
    7zz x $src
    runHook postBuild
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/{Applications,bin}
    mv 'Zed Preview.app' $out/Applications
    ln -s $out/Applications/Zed\ Preview.app/Contents/MacOS/cli $out/bin/zeditor
    runHook postInstall
  '';

  meta.mainProgram = "zeditor";
})
