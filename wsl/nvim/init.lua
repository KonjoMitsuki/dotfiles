-- init.lua: Neovimの初期化ファイル

-- lazy.nvimのパスをランタイムパスに追加（プラグインマネージャーの読み込み）
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- 基本オプションの設定を読み込み
require('options')

-- キーマップの設定を読み込み
require('keymaps')

-- プラグインの設定を読み込み
require('plugins')

-- lazy.nvimでプラグインをセットアップ
require("lazy").setup(require("plugins"))

-- カラースキームを設定（tokyonightテーマを使用）
vim.cmd.colorscheme("tokyonight")

-- ステータスラインの設定（lualine）
require("lualine").setup()

-- キーバインド表示の設定（which-key）
require("which-key").setup()

-- ファイルツリーの設定（nvim-tree）
require("nvim-tree").setup()

-- バッファラインの設定（bufferline）
require("bufferline").setup()

-- Gitの変更表示の設定（gitsigns）
require("gitsigns").setup()

-- コメント操作の設定（Comment）
require("Comment").setup()

-- 囲み文字操作の設定（nvim-surround）
require("nvim-surround").setup()

-- 自動括弧補完の設定（nvim-autopairs）
require("nvim-autopairs").setup()

-- TODOコメントの設定（todo-comments）
require("todo-comments").setup()

