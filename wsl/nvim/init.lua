-- init.lua: Neovimの初期化ファイル

-- lazy.nvimのパスをランタイムパスに追加（プラグインマネージャーの読み込み）
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- 基本オプションの設定を読み込み
require('options')

-- キーマップの設定を読み込み
require('keymaps')

-- lazy.nvimでプラグインをセットアップ（プラグイン内で setup が実行される）
require("lazy").setup(require("plugins"))

-- lsp設定（plugins 読み込み後に実行）
require('lsp')

-- 診断設定
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#ff0000" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "#e0af68" })
