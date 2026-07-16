{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.tmux =
    {
      pkgs,
      ...
    }:
    {
      programs.tmux = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.tmux-pkg;
      };
    };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.tmux-pkg = inputs.wrapper-modules.wrappers.tmux.wrap {
        inherit pkgs;
        prefix = "C-Space";
        modeKeys = "vi";
        statusKeys = "vi";
        terminal = "tmux-256color";
        terminalOverrides = ",*:RGB";
        disableConfirmationPrompt = true;
        visualActivity = true;
        vimVisualKeys = true;
        sourceSensible = true;
        secureSocket = true;
        plugins = with pkgs.tmuxPlugins; [
          vim-tmux-navigator
          yank
          catppuccin
        ];
        configBefore = ''
                  set -g @catppuccin_flavor 'mocha'

                	set -g status-position top

                	set -g status-left ""
                	set -g status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '

                	set -g status-right-length 100

                	set -g @ctp_bg "#24273a"
                	set -g @ctp_surface_1 "#494d64"
                	set -g @ctp_fg "#cad3f5"
                	set -g @ctp_mauve "#c6a0f6"
          	      set -g @ctp_crust "#181926"

                  set -g @navigate-left  'h'
                  set -g @navigate-down  'j'
                  set -g @navigate-up    'k'
                  set -g @navigate-right 'l'

                  set -g set-clipboard on

                  bind -r -N "Resize the pane left" H resize-pane -L
                  bind -r -N "Resize the pane down" J resize-pane -D
                  bind -r -N "Resize the pane up" K resize-pane -U
                  bind -r -N "Resize the pane right" L resize-pane -R

                  bind -r -N "Move the visible part of the window left" S-h refresh-client -L 20
                  bind -r -N "Move the visible part of the window up" S-j refresh-client -U 20
                  bind -r -N "Move the visible part of the window down" S-k refresh-client -D 20
                  bind -r -N "Move the visible part of the window right" S-l refresh-client -R 20

                  bind v split-window -h
                  bind s split-window -v

                	setw -g automatic-rename on
                  set -g set-titles on
        '';
      };
    };
}
