{
  ...
}:
{
  flake.nixosModules.supplementary =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        typr
        gimp2
        photoqt
        mtpfs
        bitwarden-cli
      ];
    };
}
