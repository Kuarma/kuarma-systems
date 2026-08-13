{
  ...
}:
{
  flake.nixosModules.networking =
    {
      config,
      ...
    }:
    let
      cfg = config.userInfo;
    in
    {
      networking = {
        firewall.enable = true;
        networkmanager.enable = true;
        hostName = cfg.username;
      };
    };
}
