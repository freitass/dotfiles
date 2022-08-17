-- Automatically install and set up Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  -- Keep this at the start before all plugins
  use 'wbthomason/packer.nvim'

  -- Common dependencies
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Nvim LSP (Language Server Protocol)
  -- Nvim DAP (Debug Adapter Protocol)
  --use 'neovim/nvim-lspconfig'
  --use 'williamboman/mason-lspconfig.nvim'
  --use 'williamboman/mason.nvim'
  --use 'mfussenegger/nvim-dap'

  -- Fuzzy finder
  use 'nvim-telescope/telescope.nvim'

  -- Git
  use 'TimUntersberger/neogit'

  -- Coloscheme
  use 'folke/tokyonight.nvim'


  -- Wishlist
  -- use 'folke/trouble.nvim'  -- A pretty list for showing diagnostics etc.

  -- Automatically set up your configuration after cloning packer.nvim
  -- Keep this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

