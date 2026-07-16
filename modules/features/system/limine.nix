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
          limine.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };
    };
}
