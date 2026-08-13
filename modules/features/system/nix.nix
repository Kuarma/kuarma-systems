{
  ...
}:
{
  flake.nixosModules.nix =
    {
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.userInfo;
    in
    {
      nix = {
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        settings.allowed-users = [ cfg.username ];
      };

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

      boot = {
        kernelModules = [
          "usb_storage"
          "uinput"
          "usbhid"
          "usbserial"
          "overlay"

          "nft_chain_nat"
          "xt_conntrack"
          "xt_CHECKSUM"
          "xt_MASQUERADE"
          "ipt_REJECT"
          "ip6t_REJECT"
          "nf_reject_ipv4"
          "nf_reject_ipv6"
          "xt_mark"
          "xt_comment"
          "xt_multiport"
          "xt_addrtype"
          "xt_connmark"
          "nf_conntrack_netlink"
        ];

        kernelParams = [
          "slab_nomerge"
          "page_poison=1"
          "page_alloc.shuffle=1"
          "debugfs=off"
        ];
      };

      virtualisation = {
        docker = with pkgs; {
          enable = true;
          package = docker;
        };
      };

      environment = {
        systemPackages = with pkgs; [
          sbctl
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
    };
}
