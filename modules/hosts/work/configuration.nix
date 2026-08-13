{
  self,
  ...
}:
{
  flake.nixosModules.cernConfiguration =
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
        self.nixosModules.limine
        self.nixosModules.shell

        # Applications
        self.nixosModules.neovim
        self.nixosModules.kitty
        self.nixosModules.git
        self.nixosModules.tmux
        self.nixosModules.supplementary
        self.nixosModules.btop
      ];

      networking = {
        firewall.enable = true;
        networkmanager.enable = true;
        hostName = "work";
      };

      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = true;
          KbdInteractiveAuthentication = false;
          # PermitRootLogin = "no";
          AllowUsers = [ cfg.username ];
          MaxAuthTries = 13;
          PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
        };
      };

      time.timeZone = "Europe/Zurich";

      services = {
        xe-guest-utilities.enable = true;
        xserver.xkb.layout = "ch";
        upower.enable = true;
      };

      console.keyMap = "sg";

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
        username = "cernos";
      };

      users.users.${cfg.username} = {
        isNormalUser = true;
        initialPassword = "changeme";
        shell = pkgs.zsh;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      system.stateVersion = "25.11";
    };
}
