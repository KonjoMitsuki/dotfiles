vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
-- 基本オプションの設定
require('options')

-- キーマップの設定
require('keymaps')

-- プラグインの設定
require('plugins')

-- lazy.nvim 読み込み（最初！）
-- vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- プラグイン読み込み
require("lazy").setup(require("plugins"))

-- 見た目（とりあえず）
vim.cmd.colorscheme("tokyonight")


-- &&&
vim.cmd.colorscheme("tokyonight")

require("lualine").setup()
require("which-key").setup()
require("nvim-tree").setup()
require("bufferline").setup()
require("gitsigns").setup()
require("Comment").setup()
require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("todo-comments").setup()

