{
  ...
}:
{
  flake.nixosModules.nvidia =
    {
      config,
      ...
    }:
    {
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware = {
        enableAllFirmware = true;
        nvidia = {
          modesetting.enable = true;
          powerManagement.enable = true;
          powerManagement.finegrained = false;
          open = false;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
      };

      boot = {
        blacklistedKernelModules = [ "nouveau" ];
        kernelParams = [
          "nvidia-drm.modeset=1"
          "kvm-intel"
          "quiet"
        ];
      };
    };
}
