{
  inputs,
  ...
}:
{
  perSystem =
    {
      system,
      ...
    }:
    let
      pkgs = import inputs.nixpkgs-unstable { inherit system; };
    in
    {
      packages.noctalia-pkg = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        settings = (builtins.fromJSON (builtins.readFile ./noctalia-settings.json));
      };
    };
}
