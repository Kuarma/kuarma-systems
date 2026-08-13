{
  inputs,
  ...
}:
{
  flake.nixosModules.cernPreservationConfig =
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
            {
              file = "/etc/ssh/ssh_host_ed25519_key";
              how = "symlink";
              configureParent = true;
            }
            {
              file = "/etc/ssh/ssh_host_ed25519_key.pub";
              how = "symlink";
              configureParent = true;
            }
            "/var/lib/systemd/random-seed"
          ];

          directories = [
            "/var/log"
            "/var/lib/fprint"
            "/var/lib/sbctl"
            "/var/lib/fwupd"
            "/var/lib/systemd/"
            "/var/lib/systemd/coredump"
            "/var/lib/systemd/timers"
            "/var/lib/systemd/rfkill"
            "/var/tmp"
            "/etc/NetworkManager/system-connections"
            ".local/share/docker"
            ".config/docker"
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
          ];

          users = {
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
                "Projects"
                ".gnupg"
                ".dotnet"
                ".nuget"

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
