local o = vim.opt
local g = vim.g

o.guicursor = ""
o.termguicolors = true         -- set term gui colors (most terminals support this)
o.clipboard = "unnamedplus"  -- allow neovim to access the system clipboard
o.fileencoding = "utf-8"
o.backup = false             -- disable backup files
o.swapfile = false             -- creates a swapfile
o.splitbelow = true            -- force all horizontal splits to go below current window
o.splitright = true            -- force all vertical splits to go to the right of current window

o.nu = true              -- enable line numers
o.relativenumber = true  -- number lines relative to cursor
o.cursorline = true      -- highlight the current line
o.signcolumn = "yes"     -- always display sign column to prevent UI from shifting each time
o.wrap = false           -- soft-wrap long lines
o.scrolloff = 8          -- minimal number of visible lines to keep above and below the cursor
o.sidescrolloff = 8      -- minimal number of visible lines to keep left and right of the cursor

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true  -- spaces over tabs

o.hlsearch = false    -- turn off highlighting once search term is submitted
o.incsearch = true    -- start searching as search term is typed
o.ignorecase = true   -- ignore case in search patterns (see smartcase option)
o.smartcase = true    -- override ignorecase option if search pattern contains upper case characters 
o.smartindent = true  -- autoindent when starting a new line

o.conceallevel = 0      -- so that `` is visible in markdown files

g.mapleader = " "

