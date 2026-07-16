{
  ...
}:
{
  flake.nixosModules.options =
    {
      lib,
      ...
    }:
    {
      options = {
        userInfo = {
          username = lib.mkOption {
            type = lib.types.str;
            description = "Name of the user";
          };
        };
      };
    };
}
