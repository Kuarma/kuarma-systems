{
  # self,
  # inputs,
  ...
}:
{
  flake.nixosModules.shell =
    {
      pkgs,
      ...
    }:
    {
      #TODO: To wrapper
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          syntaxHighlighting.enable = true;
          autosuggestions.enable = true;
          histSize = 10000;
          histFile = "$HOME/.zsh_history";
          setOptions = [ "HIST_IGNORE_ALL_DUPS" ];

          ohMyZsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
              "git"
              "docker"
              "docker-compose"
              "dotnet"
              "history"
              "man"
              "systemadmin"
              "sudo"
              "z"
              "fzf"
              "copypath"
              "web-search"
            ];
          };

          shellAliases = {
            ls = "eza -lh --group-directories-first --icons=auto";
            lsa = "eza --long -a";
            ll = "eza -lh";
            la = "eza -lAh";
            l = "eza -lah";
            lt = "eza --tree --level=2 --long --icons --git";
            ltt = "eza --tree --level=3 --long --icons --git";
            lttt = "eza --tree --level=4 --long --icons --git";
            tree = "eza --oneline --tree";
            n = "nvim .";
            g = "git";
            ".." = "cd ..";
            "..." = "cd ../..";
            "...." = "cd ../../..";
            md = "mkdir -p";
            rd = "rmdir";
            dc = "docker-compose";
            cg = "sudo nix-collect-garbage -d";
            ns = "sudo nixos-rebuild switch";
            "edit-in-kitty" = "kitten edit-in-kitty";
          };
        };

        zoxide = {
          enable = true;
          enableZshIntegration = true;
        };
      };

      environment.systemPackages = with pkgs; [
        eza
      ];
    };

  # perSystem =
  #   {
  #     pkgs,
  #     lib,
  #     self',
  #     ...
  #   }:
  #   {
  #     packages.zsh-pkg = inputs.wrapper-modules.wrappers.zsh.wrap {
  #       inherit pkgs;
  #     };
  #   };
}
