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
          ];

          directories = [
            "/var/lib/systemd/"
            "/etc/nixos/"
            "/var/lib/nixos"
            "/var/log"
            "/etc/NetworkManager/system-connections"
            "/var/lib/docker"
            "/var/lib/containerd"
          ];

          users = {
            ${cfg.username} = {
              directories = [
                "Projects"
                ".dotnet"
                ".nuget"
                ".local/share/NuGet"
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
