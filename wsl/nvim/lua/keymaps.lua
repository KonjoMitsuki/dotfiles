-- keymaps.lua: Neovimのキーボードショートカット設定

-- リーダーキーをスペースキーに設定
vim.g.mapleader = " "

-- キーマップ設定のヘルパー関数
local map = vim.keymap.set
-- デフォルトのオプション（再マップなし、サイレント）
local opts = { noremap = true, silent = true }

-- ===== 入力モード(i)での便利なショートカット =====
-- "jj" または "jk" を素早く押すとノーマルモードに戻る
map("i", "jj", "<Esc>", opts)
map("i", "jk", "<Esc>", opts)

-- ===== ノーマルモード(n)での便利なショートカット =====
-- Enterキーで検索ハイライトを消す
map("n", "<CR>", ":nohlsearch<CR>", opts)

-- JとKで5行ずつ高速移動
map("n", "J", "5j", opts)
map("n", "K", "5k", opts)

-- Hで行頭、Lで行末へ移動（ビジュアルモードも含む）
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("v", "H", "^", opts)
map("v", "L", "$", opts)

-- +と-キーで数値の増減
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- ^M（改行コード）をファイル全体から削除する
map("n", "<leader>m", ":%s/\\r//g<CR>", opts)

-- リーダー + w で保存、リーダー + q で終了
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)

-- ===== Telescope（検索）関連 =====
-- リーダー + ff: ファイル検索
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", opts)
-- リーダー + fg: ライブgrep検索
map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", opts)
-- リーダー + fb: バッファ検索
map("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)

-- ===== Git関連 =====
-- リーダー + gs: Gitステータス表示
map("n", "<Leader>gs", "<cmd>Git<CR>", opts)

-- ===== バッファ関連 =====
-- リーダー + bn: 次のバッファ
map("n", "<Leader>bn", "<cmd>bnext<CR>", opts)
-- リーダー + bp: 前のバッファ
map("n", "<Leader>bp", "<cmd>bprevious<CR>", opts)
-- リーダー + bd: バッファ削除
map("n", "<Leader>bd", "<cmd>bdelete<CR>", opts)

-- ===== ウィンドウ関連 =====
-- リーダー + ws: 水平分割
map("n", "<Leader>ws", "<cmd>split<CR>", opts)
-- リーダー + wv: 垂直分割
map("n", "<Leader>wv", "<cmd>vsplit<CR>", opts)
-- リーダー + wc: ウィンドウ閉じる
map("n", "<Leader>wc", "<cmd>close<CR>", opts)

-- ===== NvimTree（ファイルツリー） =====
-- リーダー + e: NvimTreeトグル
map("n", "<Leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- LSP関連
-- LSPが有効なバッファで leader + ca を押すと修正案を出す
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = true })
