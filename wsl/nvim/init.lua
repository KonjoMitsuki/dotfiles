-- init.lua: Neovimの初期化ファイル

-- lazy.nvimのパスをランタイムパスに追加（プラグインマネージャーの読み込み）
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- 基本オプションの設定を読み込み
require('options')

-- キーマップの設定を読み込み
require('keymaps')

-- プラグインの設定を読み込み
require('plugins')

-- lsp設定
require('lsp')

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


-- setup
vim.cmd.colorscheme("tokyonight")
require("lualine").setup()
require("which-key").setup()
require("bufferline").setup()
require("gitsigns").setup()
require("Comment").setup()
require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("todo-comments").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("cmp").setup({})
require("luasnip")
require("alpha").setup(require("alpha.themes.dashboard").config)

-- 2. Treesitterの設定（エラー回避のため pcall を使うとより安全です）
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if status then
    treesitter.setup({
        highlight = { enable = true },
        ensure_installed = { "lua", "vim", "vimdoc", "c", "cpp" },
    })
end

-- 3. 前の手順で作った LSP 設定を読み込む
require('lsp')

vim.diagnostic.config({
  virtual_text = true,     -- 行の横にエラー内容を表示
  signs = true,            -- 行番号の横にアイコンを表示
  underline = true,        -- エラー箇所に波線を引く
  update_in_insert = false, -- 入力中も更新する
  severity_sort = true,
})

-- init.lua の一番最後に追記
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff0000" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#e0af68" })

-- 下線が表示されないターミナルのためのフォールバック
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#ff0000" })
