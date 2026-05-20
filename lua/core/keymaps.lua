vim.g.mapleader = " "

local map = vim.keymap.set

map("i", "jk", "<Esc>")                       
map("n", "<leader>w", ":w<CR>")               
map("n", "<leader>q", ":q<CR>")               
map("n", "<C-h>", "<C-w>h")                   
map("n", "<C-l>", "<C-w>l")                   
map("n", "<C-j>", "<C-w>j")                   
map("n", "<C-k>", "<C-w>k")                   

map("n", "<leader>n", ":NeoTree toggle<CR>")

