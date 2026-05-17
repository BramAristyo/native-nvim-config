vim.g.mapleader        = " "
vim.opt.number         = true
vim.opt.relativenumber = false 
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.clipboard      = "unnamedplus" 

local map = vim.keymap.set
map("i", "jk", "<Esc>")                       
map("n", "<leader>w", ":w<CR>")               
map("n", "<leader>q", ":q<CR>")               
map("n", "<C-h>", "<C-w>h")                   
map("n", "<C-l>", "<C-w>l")                   
map("n", "<C-j>", "<C-w>j")                   
map("n", "<C-k>", "<C-w>k")                   

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "pyright" }, 
        automatic_installation = true,
      })
    end },

  { "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("gopls",  {})
      vim.lsp.config("pyright", {})
      vim.lsp.enable({ "gopls", "pyright" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local o = { buffer = e.buf }
          map("n", "gd",         vim.lsp.buf.definition, o) 
          map("n", "K",          vim.lsp.buf.hover,      o) 
          map("n", "<leader>rn", vim.lsp.buf.rename,     o) 
        end,
      })
    end },

  { "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]   = cmp.mapping.select_next_item(), 
          ["<S-Tab>"] = cmp.mapping.select_prev_item(), 
          ["<CR>"]    = cmp.mapping.confirm({ select = true }), 
        }),
        sources = { { name = "nvim_lsp" }, { name = "buffer" } },
      })
    end },

    {   "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true },  
        {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
    
})
