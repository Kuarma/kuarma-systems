{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.neovim =
    {
      pkgs,
      ...
    }:
    let
      dotnet =
        with pkgs.dotnetCorePackages;
        combinePackages [
          sdk_10_0_1xx
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

      environment = {
        extraInit = ''
          export PATH="$HOME/.dotnet/tools:$PATH"
        '';

        systemPackages = with pkgs; [
          mono
          nuget
          dotnet
          dotnet-ef
          dotnet-outdated
          nodejs_22
          luaPackages.tree-sitter-cli
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
            ffmpeg-full
            wl-clipboard
            xdotool
            pstree
            lua-language-server
            oxfmt
            marksman
            netcoredbg
          ]
          ++ [
            stablePkgs.vscode-langservers-extracted
            stablePkgs.codespell
          ];

        specs.init = {
          data = null;
          before = [ "MAIN_INIT" ];
          config = "require('init')";
        };

        specs.plugins = {
          data = with pkgs.vimPlugins; [
            nvim-treesitter.withAllGrammars
            nvim-treesitter-textobjects
            nvim-ts-autotag
            nvim-lspconfig
            blink-cmp
            colorful-menu-nvim
            lspkind-nvim
            luasnip
            lz-n
            plenary-nvim
            nvim-nio
            vim-tmux-navigator
            tokyonight-nvim
            nvim-web-devicons
            nui-nvim
            nvim-colorizer-lua
            noice-nvim
            nvim-notify
            which-key-nvim
            snacks-nvim
            alpha-nvim
            lualine-nvim
            easy-dotnet-nvim
            nvim-dap
            oil-nvim
            undotree
          ];
        };

        specs.lazyPlugins = {
          lazy = true;
          data = with pkgs.vimPlugins; [
            nvim-dap-ui
            nvim-dap-view
            nvim-dap-virtual-text
            oil-git-status-nvim
            oil-lsp-diagnostics-nvim
            nvim-autopairs
            inc-rename-nvim
            gitsigns-nvim
            lazygit-nvim
            harpoon2
            todo-comments-nvim
            friendly-snippets
            lazydev-nvim
            conform-nvim
            trouble-nvim
            nvim-bqf
            telescope-nvim
            telescope-fzf-native-nvim
            telescope-media-files-nvim
            telescope-ui-select-nvim
          ];
        };
      };
    };
}
