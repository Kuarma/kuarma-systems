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
        gimp2
        photoqt
        mtpfs
        calibre
      ];
    };
}
