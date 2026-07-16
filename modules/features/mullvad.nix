{
  ...
}:
{
  flake.nixosModules.mullvad =
    {
      pkgs,
      ...
    }:
    {
      services.mullvad-vpn = {
        enable = true;
        package = pkgs.mullvad;
        enableEarlyBootBlocking = true;
        enableExcludeWrapper = false;
      };
    };
}
