{
  ...
}:
{
  flake.nixosModules.cernHardware =
    {
      ...
    }:
    {
      imports = [ ];

      boot.initrd.availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "sr_mod"
        "xen_blkfront"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];
    };
}
