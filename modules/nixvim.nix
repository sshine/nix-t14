{ inputs, ... }:
{
  flake.nixosModules.nixvim =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.nixvim.nixosModules.default
      ];

      nixpkgs.overlays = [
        inputs.nixvim.overlays.default
      ];

      environment.systemPackages = [
        pkgs.nixpkgs-fmt
      ];

      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;

        globals.mapleader = " ";

        opts = {
          modelines = 3;
          number = false;
          shiftwidth = 2;
          tabstop = 2;
          expandtab = true;
          shiftround = true;
          textwidth = 100;
          cindent = false;
          smartindent = false;
          autoindent = true;
          mouse = "";
          scrolloff = 3;
          ignorecase = true;
          smartcase = true;
          showmatch = true;
        };

        plugins.telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
          };
        };
        plugins.web-devicons.enable = true;
        plugins.lualine.enable = true;
        plugins.conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              nix = [ "nixpkgs-fmt" ];
            };

            formatters = {
              "nixpkgs-fmt".command = lib.getExe pkgs.nixpkgs-fmt;
            };
          };
        };
      };
    };
}
