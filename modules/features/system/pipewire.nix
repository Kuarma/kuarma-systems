{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.pipewire =
    {
      pkgs,
      ...
    }:
    {
      services = {
        playerctld.enable = true;
        pipewire = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.pipewire-stable;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          wireplumber.enable = true;
        };
      };
      security.rtkit.enable = true;
    };

  perSystem =
    {
      system,
      ...
    }:
    let
      stablePkgs = import inputs.nixpkgs-stable {
        inherit system;
      };
    in
    {
      packages.pipewire-stable = stablePkgs.pipewire;
    };
}
