{ inputs, ... }:

let
  mkExtensionSettings = builtins.mapAttrs (
    _: pluginId: {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
      installation_mode = "force_installed";
    }
  );
in

{
  den.aspects.zen = {
    _.to-users = {
      homeManager = {
        imports = [ inputs.zen-browser.homeModules.default ];

        programs.zen-browser = {
          enable = true;
          profiles.default = {
            mods = [ ];
            presets.betterfox.enable = true;
            # search.default = "google";
            # search.engines = {
            #   github = {
            #     definedAliases = [ "gh" ];
            #     name = "GitHub";
            #     urls = [ { template = "https://github.com/{searchTerms}"; } ];
            #   };
            # };
            # search.force = true;
          };

          profiles.default.settings = {
            "zen.urlbar.behavior" = "float";
            "zen.view.compact.hide-tabbar" = true;
            "zen.welcome-screen.seen" = true;
            "zen.workspaces.continue-where-left-off" = true;
          };

          policies = {
            AutofillAddressEnabled = true;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            EnableTrackingProtection = {
              Cryptomining = true;
              Fingerprinting = true;
              Locked = true;
              Value = true;
            };

            ExtensionSettings = mkExtensionSettings {
              "addon@darkreader.org" = "darkreader";
              "uBlock0@raymondhill.net" = "ublock-origin";
            };

            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
          };

          setAsDefaultBrowser = true;
        };
      };
    };
  };
}
