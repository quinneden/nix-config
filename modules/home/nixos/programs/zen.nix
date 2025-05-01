{
  pkgs,
  inputs,
  ...
}:
let
  # settings = ''
  #   {
  #     "config": {
  #       "title" : "Homepage",
  #       "openLinksInNewTab": false,
  #       "locale": "en-US",
  #       "colors": {
  #         "primary": "#20bcfc",
  #         "background": "#181818",
  #         "foreground": "#d0d0d0",
  #         "muted": "#747474"
  #       },
  #       "folders": [
  #         {
  #           "name": "Pins",
  #           "links": [
  #             {"title": "ChatGPT", "url": "https://chat.openai.com/", "icon": "󰭹"},
  #             {"title": "Github", "url": "https://github.com", "icon": ""},
  #             {"title": "Github", "url": "https://github.com/quinneden?tab=repositories", "icon": ""},
  #             {"title": "Home-Manager Options", "url": "https://nix-community.github.io/home-manager/options.xhtml", "icon": ""},
  #             {"title": "NixOS Manual", "url": "https://nixos.org/manual/nixos/unstable", "icon": ""},
  #             {"title": "NixOS/nixpkgs", "url": "https://github.com/nixos/nixpkgs", "icon": ""},
  #             {"title": "NixOS Search", "url": "https://search.nixos.org", "icon": ""}
  #           ]
  #         }
  #       ]
  #     }
  #   }
  # '';

  #   homepage = pkgs.buildNpmPackage {
  #     pname = "homepage";
  #     version = "0.1.0";
  #
  #     src = pkgs.fetchFromGitHub {
  #       owner = "quinneden";
  #       repo = "homepage";
  #       rev = "refs/heads/main";
  #       hash = "sha256-1GYZByEhjVNsYaikNEt4GObITXEP6gHDSw022OUmrsE=";
  #     };
  #
  #     npmDepsHash = "sha256-bG+CHTq2Rst3JMxsjAC81KhK+G7WwsTVD1eyP87g0z4=";
  #
  #     buildPhase = ''
  #       npm install
  #       cp ${pkgs.writeText "src/routes/config.json" settings} src/routes/config.json
  #       npm run build
  #       mkdir $out
  #       mv build $out
  #     '';
  #
  #     meta = {
  #       description = "homepage";
  #       homepage = "https://github.com/quinneden/homepage";
  #     };
  #   };
in
{
  # home.file.".config/homepage" = {
  #   source = "${homepage}/build";
  #   recursive = true;
  # };

  home.packages = with pkgs; [ inputs.zen-browser.packages."${system}".default ];
}
