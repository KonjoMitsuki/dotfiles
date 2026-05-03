-- options.lua: Neovimの基本設定

-- 行番号と相対行番号を表示
vim.opt.number = true
vim.opt.relativenumber = true

-- マウス操作を有効化（すべてのモードでマウスを使用可能）
vim.opt.mouse = "a"
-- クリップボードをシステムクリップボードに連携（コピー/ペーストがOSと同期）
vim.opt.clipboard = "unnamedplus"
-- 保存時に自動で改行コードをUnix(LF)に変換し、^Mを削除する設定
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\r//ge]])
    vim.fn.setpos(".", save_cursor)
  end,
})
-- 検索時に大文字小文字を無視
vim.opt.ignorecase = true
-- 大文字が含まれている場合のみ大文字小文字を区別（ignorecaseと組み合わせ）
vim.opt.smartcase = true
-- 長い行を折り返して表示しない
vim.opt.wrap = false
-- 右側に縦分割を開く
vim.opt.splitright = true
-- カーソル行をハイライト表示
vim.opt.cursorline = true
-- カーソル上下に8行の余白を確保（スクロール時の快適さ向上）
vim.opt.scrolloff = 8
-- 24ビットカラーを有効化（より豊かな色表現）
vim.opt.termguicolors = true

-- インデントをスペース4つに統一
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- WSL環境でのクリップボード設定（システムクリップボードとの連携）
vim.opt.clipboard = "unnamedplus"

-- ターミナルを開いた時に自動的に挿入モードに入る
vim.api.nvim_create_autocmd({"TermOpen"}, {
  pattern = "*",
  command = "startinsert",
})