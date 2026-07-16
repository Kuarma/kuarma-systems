{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.lunix = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.lunaConfiguration
      self.nixosModules.lunaDiskoConfig
      self.nixosModules.lunaPreservationConfig
      self.nixosModules.lunaHardware
      self.nixosModules.options
    ];
  };
}
