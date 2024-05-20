{ flake, ... }: {
  imports = [ flake.inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = ",";
      maplocalleader = ",";
    };

    # Theme
    # colorschemes.tokyonight.enable = true;

    # Settings
    opts = {
      expandtab = true;
      shiftwidth = 4;
      smartindent = true;
      tabstop = 2;
      number = true;
      clipboard = "unnamedplus";
      # filetype = true;

      # search
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      incsearch = true;

      # terminal
      # term = "xterm-256color";
      title = true;
      titlestring = "%F";
      laststatus = 2;
      statusline =
        "%F%m%r%h%w%=(%{&ff}/%Y) (line %l/%L, col %c)%{fugitive#statusline()}";
      mouse = "a";
    };

    # Keymaps
    keymaps = [
      {
        mode = [ "i" "" "c" ];
        key = "<leader> ";
        action = "<esc>";
        options.noremap = true;
      }
      {
        key = "<space>";
        action = ":";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<leader> ";
        options.silent = true;
        action = ":noh<cr>";
      }
      {
        key = "<leader>n";
        action = ":Neotree<cr>";
      }
      {
        key = "<f1>";
        action = ":bprev<CR>";
        options.noremap = true;
      }
      {
        key = "<f2>";
        action = ":bnext<CR>";
        options.noremap = true;
      }
      {
        key = "{";
        action = ":copen<CR>";
        options.noremap = true;
        mode = "n";
        options.silent = true;
      }
      {
        key = "}";
        action = ":cclose<CR>";
        options.noremap = true;
        mode = "n";
        options.silent = true;
      }
      {
        key = "(";
        action = ":lopen<CR>";
        options.noremap = true;
        mode = "n";
        options.silent = true;
      }
      {
        key = ")";
        action = ":lclose<CR>";
        options.noremap = true;
        mode = "n";
        options.silent = true;
      }
    ];

    plugins = {

      # UI
      airline = {
        enable = true;
        settings = {
          # theme = "powerlineish";
          powerline_fonts = true;
          symbols = {
            branch = "";
            readonly = "";
            linenr = "";
          };
        };
      };
      # lualine.enable = true;
      bufferline.enable = true;
      treesitter.enable = true;
      neo-tree.enable = true;
      lsp-lines.enable = true;
      which-key = { enable = true; };
      toggleterm = {
        enable = true;
        settings.winbar = { enabled = true; };
      };
      noice = {
        # WARNING: This is considered experimental feature, but provides nice UX
        enable = true;
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          #inc_rename = false;
          #lsp_doc_border = false;
        };
      };
      none-ls = {
        enable = true;
        sources = {
          formatting = {
            gofumpt.enable = true;
            goimports_reviser.enable = true;
            golines.enable = true;
            nixfmt.enable = true;
            hclfmt.enable = true;
            stylua.enable = true;
            pg_format.enable = true;
            prettierd.enable = true;
            shfmt.enable = true;
            yamlfmt.enable = true;
          };
        };
        onAttach = ''
          function(client, bufnr)
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({
                  group = augroup,
                  buffer = bufnr
              })
              vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                      vim.lsp.buf.format({
                          bufnr = bufnr
                      })
                  end
              })
            end
          end
        '';
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>fg" = "live_grep";
          "<leader>ff" = "find_files";
          "<leader>b" = "buffers";
          # "<esc>" = "require('telescope.actions').close()";
        };
        keymapsSilent = true;
        extensions = {
          file-browser.enable = true;
          undo.enable = true;
        };
      };

      # completion
      cmp-buffer.enable = true;
      cmp-cmdline.enable = true;
      luasnip.enable = true;
      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          sources = [
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
          ];
        };
      };
      lspkind = {
        enable = true;
        cmp = { enable = true; };
      };

      # status
      neogit.enable = true;

      # language
      comment.enable = true;
      surround.enable = true;

      # Dev
      lsp = {
        enable = true;
        servers = {
          hls.enable = true;
          marksman.enable = true;
          nil_ls = {
            enable = true;
            settings.formatting.command = [ "nixpkgs-fmt" ];
          };
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };
    };
  };
}
