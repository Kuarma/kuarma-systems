{
  ...
}:
{
  flake.nixosModules.librewolf =
    {
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.userInfo;
    in
    {
      programs.firefox = {
        enable = true;
        package = pkgs.librewolf;
        policies = {
          ManagedBookmarks = [
            {
              name = "Search";
              children = [
                {
                  name = "NixOS";
                  url = "https://search.nixos.org/";
                }
                {
                  name = "Noogle";
                  url = "https://noogle.dev/";
                }
              ];
            }
            {
              name = "GitHub";
              url = "https://github.com/";
            }
          ];
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          Preferences = {
            "cookiebanners.service.mode.privateBrowsing" = 2;
            "cookiebanners.service.mode" = 2;
            "privacy.donottrackheader.enabled" = true;
            "privacy.fingerprintingProtection" = true;
            "privacy.resistFingerprinting" = true;
            "privacy.trackingprotection.emailtracking.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.clearOnShutdown_v2.cookiesAndStorage.enabled" = false;
          };
          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };

            "jid1-ZAdIEUB7XOzOJw@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
              installation_mode = "force_installed";
            };

            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };

      environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";

      environment.etc."firejail/librewolf.local".text = ''
        whitelist ${config.users.users.${cfg.username}.home}/.config/librewolf
      '';

      preservation.preserveAt."/persistent".users.${cfg.username}.directories = [
        ".config/librewolf"
      ];

      programs.firejail = {
        enable = true;
        wrappedBinaries = {
          librewolf = {
            executable = "${pkgs.librewolf}/bin/librewolf";
            profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
            extraArgs = [
              "--ignore=private-dev"
              "--env=GTK_THEME=Adwaita:dark"
              "--dbus-user.talk=org.freedesktop.Notifications"
            ];
          };
        };
      };
    };
}
