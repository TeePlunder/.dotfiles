--- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use ('wbthomason/packer.nvim')

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { "ellisonleao/gruvbox.nvim" }

    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use ('nvim-treesitter/playground')
    use ('theprimeagen/harpoon')
    use ('mbbill/undotree')
    use ('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            -- {'hrsh7th/cpm-buffer'},
            -- {'hrsh7th/cpm-path'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'}
        }
    }

    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    use ({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local null_ls = require("null-ls")

            local opts = {
                sources = {
                    null_ls.builtins.formatting.clang_format
                },
                on_attach = function(client, bufnr)
                    if client.supports_methodd("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            grouo = augroup,
                            buffer = bufnr,})
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                group = augroup,
                                buffer = bufnr,
                                callback = function()
                                    vim.lsp.buf.format({bufnur= bufnur})
                                end,
                            })
                        end
                    end
                }
                return opts
            end,
            requires = { "nvim-lua/plenary.nvim" },
        })
        use {
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        }
        use 'mfussenegger/nvim-dap'
        use 'rcarriga/nvim-dap-ui'

    --     use {"mfussenegger/nvim-dap",
    --     event = "VimEnter",
    --     config = function()
    --         local M = {}
    --         M.dap ={
    --             plugin = true,
    --             n = {
    --                 ["<leader>db"] = {
    --                     "<cmd> DapToggleBreakpoint <CR>",
    --                     "Add breakpoint at line",
    --                 },
    --                 ["<leader>dr"] = {
    --                     "<cmd> DapContinue <CR>",
    --                     "Start or continue the debugger",
    --                 }
    --             }
    --         }
    --     end
    -- }
    --
    -- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"},event = 'VimEnter', module = 'dapui',
    -- config = function()
    --     local dap, dapui = require("dap"), require("dapui")
    --     dap.listeners.after.event_initialized["dapui_config"] = function()
    --         dapui.open()
    --     end
    --     dap.listeners.before.event_terminated["dapui_config"] = function()
    --         dapui.close()
    --     end
    --     dap.listeners.before.event_exited["dapui_config"] = function()
    --         dapui.close()
    --     end
    -- end}
    
    use {
      'filipdutescu/renamer.nvim',
      branch = 'master',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

end)
