local remap = require("user.keymap")
local nmap = remap.nmap
local nnoremap = remap.nnoremap
local vnoremap = remap.vnoremap
local xnoremap = remap.xnoremap
local inoremap = remap.inoremap

-- project view
nnoremap("<leader>e", ":Lexplore 25<CR>")

-- change window
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- to normal mode (from insert)
inoremap("jk", "<Esc>")

-- yank to clipboard, paste from clipboard
nnoremap("<leader>Y", "\"*y")
nnoremap("<leader>P", "\"+p")
 
