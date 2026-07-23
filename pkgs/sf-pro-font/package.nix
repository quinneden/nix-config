{
  _7zz,
  fetchurl,
  stdenv,
}:

stdenv.mkDerivation {
  name = "sf-pro-font";

  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    hash = "sha256-YxGk8IQ6TS5hagsFx3US0x0uqVBFnPUmzbW5CZageU8=";
  };

  nativeBuildInputs = [ _7zz ];

  unpackPhase = ''
    runHook preUnpack
    7zz x $src
    7zz x 'SFProFonts/SF Pro Fonts.pkg'
    7zz x 'SFProFonts.pkg/Payload'
    7zz x 'Payload~'
    runHook postUnpack
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/{opentype,truetype}
    find Library/Fonts -name "*.otf" -exec mv {} $out/share/fonts/opentype \;
    find Library/Fonts -name "*.ttf" -exec mv {} $out/share/fonts/truetype \;
    runHook postInstall
  '';
}
