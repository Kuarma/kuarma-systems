{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.work = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.cernConfiguration
      self.nixosModules.cernDiskoConfig
      self.nixosModules.cernPreservationConfig
      self.nixosModules.cernHardware
      self.nixosModules.options
    ];
  };
}
