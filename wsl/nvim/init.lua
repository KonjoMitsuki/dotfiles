-- init.lua: Neovimの初期化ファイル

-- lazy.nvimのパスをランタイムパスに追加（プラグインマネージャーの読み込み）
-- wsl/nvim/init.lua の冒頭をこれに差し替え
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

-- 基本オプションの設定を読み込み
require('options')

-- キーマップの設定を読み込み
require('keymaps')

-- lazy.nvimでプラグインをセットアップ（プラグイン内で setup が実行される）
-- init.lua の setup 部分を修正
require("lazy").setup(require("plugins"), {
  root = vim.fn.stdpath("data") .. "/lazy", -- インストール先を明示
})

-- lsp設定（plugins 読み込み後に実行）
-- require('lsp')

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
