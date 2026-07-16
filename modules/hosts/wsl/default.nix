{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.nixdows = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.nixos-wsl.nixosModules.default

      self.nixosModules.nixdowsConfig
      self.nixosModules.options
    ];
  };
}
