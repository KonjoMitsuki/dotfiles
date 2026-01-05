-- options.lua: Neovimの基本設定

-- 行番号を表示
vim.opt.number = true
-- 相対行番号を表示（カーソル行からの相対的な行番号）
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
-- 長い行を折り返して表示
vim.opt.wrap = true
-- カーソル行をハイライト表示
vim.opt.cursorline = true
-- カーソル上下に8行の余白を確保（スクロール時の快適さ向上）
vim.opt.scrolloff = 8
-- 24ビットカラーを有効化（より豊かな色表現）
vim.opt.termguicolors = true

-- WSL環境でのクリップボード設定（システムクリップボードとの連携）
vim.opt.clipboard = "unnamedplus"
