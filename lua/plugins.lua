return require('packer').startup(function()
use 'wbthomason/packer.nvim'

use 'shaunsingh/moonlight.nvim'
	require('moonlight').set()

use {
    'w0rp/ale',
    cmd = 'ALEEnable'
}

-- TODO 
-- FIX
-- HACK

use {
  "folke/todo-comments.nvim",
  config = function()
    require("todo-comments").setup {}
  end
}

use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {}
  end
}

use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  }
}

-- use {
-- 'nvim-telescope/telescope.nvim',
-- requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
-- }
end)
