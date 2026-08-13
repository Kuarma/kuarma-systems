{
  self,
  ...
}:
{
  flake.nixosModules.lunaConfiguration =
    {
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.userInfo;
    in
    {
      imports = [
        # System
        self.nixosModules.nix
        self.nixosModules.nvidia
        self.nixosModules.limine
        self.nixosModules.pipewire
        self.nixosModules.shell
        self.nixosModules.networking

        # Applications
        self.nixosModules.niri
        self.nixosModules.neovim
        self.nixosModules.kitty
        self.nixosModules.librewolf
        self.nixosModules.gaming
        self.nixosModules.git
        self.nixosModules.tmux
        self.nixosModules.mullvad
        self.nixosModules.supplementary
        self.nixosModules.btop
      ];

      time.timeZone = "Europe/Zurich";

      services = {
        xserver.xkb.layout = "ch";
        upower.enable = true;
      };

      hardware.openrazer.enable = true;
      hardware.openrazer.users = [ cfg.username ];

      environment.systemPackages = with pkgs; [
        razergenie
      ];

      i18n = {
        defaultLocale = "en_US.UTF-8";

        extraLocaleSettings = {
          LC_ADDRESS = "de_CH.UTF-8";
          LC_IDENTIFICATION = "de_CH.UTF-8";
          LC_MEASUREMENT = "de_CH.UTF-8";
          LC_MONETARY = "de_CH.UTF-8";
          LC_NAME = "de_CH.UTF-8";
          LC_NUMERIC = "de_CH.UTF-8";
          LC_PAPER = "de_CH.UTF-8";
          LC_TELEPHONE = "de_CH.UTF-8";
          LC_TIME = "de_CH.UTF-8";
        };
      };

      userInfo = {
        username = "luna";
      };

      users.users.${cfg.username} = {
        isNormalUser = true;
        initialPassword = "changeme";
        shell = pkgs.zsh;
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "input"
        ];
      };

      system.stateVersion = "25.11";
    };
}
