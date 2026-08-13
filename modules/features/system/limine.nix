{
  ...
}:
{
  flake.nixosModules.limine =
    {
      ...
    }:
    {
      boot = {
        plymouth.enable = true;
        loader = {
          limine = {
            enable = true;
            secureBoot.enable = false;
          };
          efi.canTouchEfiVariables = true;
        };
      };
    };
}
