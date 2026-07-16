{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.neovim =
    {
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.userInfo;

      dotnet =
        with pkgs.dotnetCorePackages;
        combinePackages [
          sdk_10_0
          sdk_9_0
          sdk_8_0
        ];
    in
    {
      programs = {
        neovim = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-pkg;
          defaultEditor = true;
          viAlias = true;
        };
      };

      preservation.preserveAt."/persistent".users.${cfg.username}.directories = [
        "Projects"
      ];

      environment = {
        extraInit = ''
          export PATH="$HOME/.dotnet/tools:$PATH"
        '';

        systemPackages = with pkgs; [
          # CSharp
          dotnet
          dotnet-ef

          # Node
          nodejs_22

          # Treesitter
          luaPackages.tree-sitter-cli

          # Resharper
          self.packages.${pkgs.stdenv.hostPlatform.system}.resharper-pkg

          # Misc
          fzf
          ripgrep
        ];

        sessionVariables = {
          DOTNET_ROOT = "${dotnet}/share/dotnet";
          DOTNET_ROOT_X64 = "${dotnet}/share/dotnet";
          DOTNET_MULTILEVEL_LOOKUP = "0";
          DOTNET_CLI_TELEMETRY_OPTOUT = "1";
          DOTNET_NOLOGO = "1";
        };
      };
    };

  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    let
      stablePkgs = import inputs.nixpkgs-stable { inherit system; };
    in
    {
      packages.nvim-pkg = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;

        settings.config_directory = ./.;

        runtimePkgs =
          with pkgs;
          [
            # System utilities
            ffmpeg-full
            wl-clipboard
            biber
            miktex
            zathura
            xdotool
            pstree

            # LSP servers
            lua-language-server

            # Formatters
            oxfmt
            tex-fmt
            bibtex-tidy

            # Markdown
            marksman

            # Dbg CSharp
            netcoredbg
          ]
          ++ [
            stablePkgs.vscode-langservers-extracted

            # Spelling
            stablePkgs.codespell
          ];

        specs.init = {
          data = null;
          before = [ "MAIN_INIT" ];
          config = "require('init')";
        };

        specs.plugins = {
          data = with pkgs.vimPlugins; [
            # Treesitter
            nvim-treesitter.withAllGrammars
            nvim-treesitter-textobjects
            nvim-ts-autotag

            # LSP
            nvim-lspconfig

            # Completion & snippets
            blink-cmp
            blink-compat
            colorful-menu-nvim
            lspkind-nvim
            luasnip

            # Latex
            vimtex

            # Core dependencies
            lz-n
            plenary-nvim
            nvim-nio

            # Navigation
            vim-tmux-navigator

            # UI & appearance
            tokyonight-nvim
            nvim-web-devicons
            nui-nvim
            nvim-colorizer-lua
            noice-nvim
            nvim-notify
            which-key-nvim
            snacks-nvim

            # Start screen & statusline
            alpha-nvim
            lualine-nvim

            # Language-specific
            easy-dotnet-nvim

            # Debugging
            nvim-dap

            # File explorer
            oil-nvim
          ];
        };

        specs.lazyPlugins = {
          lazy = true;
          data = with pkgs.vimPlugins; [
            # Debugging
            nvim-dap-ui
            nvim-dap-view
            nvim-dap-virtual-text

            # File explorer
            oil-git-nvim
            oil-lsp-diagnostics-nvim

            # Editing
            nvim-autopairs
            inc-rename-nvim

            # Git
            gitsigns-nvim
            lazygit-nvim

            # Navigation & project management
            harpoon2

            # Notes & task tracking
            todo-comments-nvim

            # Development helpers
            lazydev-nvim
            conform-nvim

            # History
            undotree

            # Diagnostics & quickfix
            trouble-nvim
            nvim-bqf

            # Telescope
            telescope-nvim
            telescope-fzf-native-nvim
            telescope-media-files-nvim
            telescope-ui-select-nvim
          ];
        };
      };
    };
}
