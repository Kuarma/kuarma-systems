{
  inputs,
  ...
}:
{
  flake.nixosModules.lunaPreservationConfig =
    {
      config,
      ...
    }:
    let
      cfg = config.userInfo;
    in
    {
      imports = [
        inputs.preservation.nixosModules.default
      ];

      boot = {
        tmp.cleanOnBoot = true;
        initrd.systemd.enable = true;
      };

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

      preservation = {
        enable = true;

        preserveAt."/persistent" = {
          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];

          directories = [
            "/var/log"
            "/var/lib/fprint"
            "/var/lib/fwupd"
            "/var/lib/systemd"
            "/var/lib/systemd/coredump"
            "/var/lib/systemd/timers"
            "/var/lib/systemd/rfkill"
            "/var/lib/systemd/random-seed"
            "/var/tmp"
            "/etc/NetworkManager/system-connections"
            "/etc/mullvad-vpn"
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
          ];
          users = {
            # mutableUsers = false;
            ${cfg.username} = {
              commonMountOptions = [
                "x-gvfs-hide"
              ];
              directories = [
                {
                  directory = ".ssh";
                  mode = "0700";
                }
                "Preserve"
                ".gnupg"
                ".dotnet"
                ".local/share/direnv"
                ".local/state/nix"
                ".local/state/wireplumber"
                ".local/share/keyrings"
              ];
              files = [
                ".zsh_history"
              ];
            };
          };
        };
      };
    };
}
