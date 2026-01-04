vim.g.mapleader = " " -- スペ�EスキーをLeaderに
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 【入力モード(i)での便利技】
-- "jj" または "jk" を素早く押すとEsc（ノーマルモードに戻る）
map("i", "jj", "<Esc>", opts)
map("i", "jk", "<Esc>", opts)


-- 【ノーマルモード(n)での便利技】
-- 検索ハイライトをEnterキー一発で消す
map("n", "<CR>", ":nohlsearch<CR>", opts)

-- JとKで5行ずつ高速移動
map("n", "J", "5j", opts)
map("n", "K", "5k", opts)

-- Hで行頭、Lで行末へ移動（Shiftを押しながらh/l）
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("v", "H", "^", opts)
map("v", "L", "$", opts)

-- 数値の増減（+と-キーで）
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- 保存と終了（スペース + w / q）
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)

-- keymaps.lua: キーボードショートカットの設定

-- 今はまだ設定がありませんが、将来ここに自分好みのショートカットを追加していきます。
-- 例: スペースキー2回で、検索のハイライトを消す
vim.keymap.set('n', '<Space><Space>', ':nohlsearch<CR>')

-- ===== Find =====
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)

-- ===== Git =====
map("n", "<Leader>gs", "<cmd>Git<CR>", opts)

-- ===== Buffer =====
map("n", "<Leader>bn", "<cmd>bnext<CR>", opts)
map("n", "<Leader>bp", "<cmd>bprevious<CR>", opts)
map("n", "<Leader>bd", "<cmd>bdelete<CR>", opts)

-- ===== Window =====
map("n", "<Leader>ws", "<cmd>split<CR>", opts)
map("n", "<Leader>wv", "<cmd>vsplit<CR>", opts)
map("n", "<Leader>wc", "<cmd>close<CR>", opts)

-- ===== NvimTree =====
map("n", "<Leader>e", "<cmd>NvimTreeToggle<CR>", opts)
-- a