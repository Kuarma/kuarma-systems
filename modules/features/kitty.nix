{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.kitty =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.kitty-pkg
      ];
    };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.kitty-pkg = inputs.wrapper-modules.wrappers.kitty.wrap {
        inherit pkgs;

        font = {
          name = "JetBrains Mono";
          size = 11.5;
        };

        # themeFile = "Atom";

        settings = {
          background_opacity = 90;
          background_blur = 5;

          allow_remote_control = true;
          cursor_blink_interval = 0;
          cursor_beam_thickness = 1.5;

          enable_audio_bell = false;

          scrollback_lines = 5000;
          scrollback_pager = "bat --style plain";

          window_padding_width = 20;
          placement_strategy = "center";

          tab_bar_style = "powerline";
          tab_powerline_style = "round";
          tab_bar_min_tabs = 2;

          detect_urls = true;

          repaint_delay = 8;
          input_delay = 1;
          sync_to_monitor = true;

          mouse_hide_wait = 5.0;
          hide_window_decorations = false;
        };
      };
    };
}
