{
  ...
}:
{
  flake.nixosModules.nix =
    {
      pkgs,
      ...
    }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc.lib
          zlib
          openssl
          icu
          libunwind
          curl
          krb5
          lttng-ust
        ];
      };

      services.gvfs.enable = true;

      virtualisation.docker = with pkgs; {
        enable = true;
        package = docker;
      };

      environment.systemPackages = with pkgs; [
        unzip

        # Formatters
        stylua
        alejandra
        manix
        nix-inspect
        nixd
        statix
        nixfmt
        dockerfmt
        yamlfmt
        csharpier
      ];
    };
}
