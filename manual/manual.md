# Neovim設定 & Luaマニュアル

このマニュアルでは、Neovimの設定方法とLuaプログラミングの基本について説明します。

---
ははは

## 目次

1. [Neovimの基本構成](#neovimの基本構成)
2. [Luaの基本文法](#luaの基本文法)
3. [Neovimでの設定方法](#neovimでの設定方法)
4. [プラグイン管理（lazy.nvim）](#プラグイン管理lazynvim)
5. [実践例](#実践例)

---

## Neovimの基本構成

### ディレクトリ構成

```
~/.config/nvim/
├── init.lua              # メインの設定ファイル
├── lazy-lock.json        # プラグインのロック情報
└── lua/                  # Luaモジュール置き場
    ├── options.lua       # エディタの基本設定
    ├── keymaps.lua       # キーバインディング
    ├── plugins.lua       # プラグイン管理
    └── lsp.lua           # LSP（言語サーバー）設定
```

### 各ファイルの役割

| ファイル | 役割 |
|---------|------|
| `init.lua` | 初期化ファイル。他のモジュールを読み込み、全体的な設定を行う |
| `options.lua` | 行番号、インデント、検索方式など基本的なエディタ設定 |
| `keymaps.lua` | キーボードショートカット設定の**実装**ファイル |
| `keybinds.md`| キーボードショートカットの**一覧と説明** |
| `plugins.lua` | 使用するプラグインのリスト |
| `lsp.lua` | 言語サーバーの設定（補完、診断など） |
| `lazy-lock.json` | プラグインのバージョン管理ファイル（自動生成） |

### init.luaの基本構造

```lua
-- 設定の読み込み順序
require('options')    -- 基本設定を最初に読み込む
require('keymaps')    -- キーマップを読み込む
require("lazy").setup(require("plugins"))  -- プラグイン管理を初期化
require('lsp')        -- LSP設定を読み込む（プラグイン後）

-- カラースキームの設定
vim.cmd.colorscheme("dracula")

-- 各プラグインのセットアップ
require("lualine").setup()
require("which-key").setup()
```

---

## Luaの基本文法

### 1. 変数と型

```lua
-- 変数宣言（ローカルスコープ推奨）
local name = "Neovim"
local version = 0.9
local is_enabled = true
local items = { 1, 2, 3 }
local config = { name = "test", value = 10 }

-- グローバル変数（スコープ指定なし）
global_var = "global"  -- 非推奨（スコープ汚染）

-- 定数パターン（慣例）
local MAX_BUFFER_SIZE = 1024
```

#### 主な型

- `string` - 文字列 (`"hello"` または `'hello'`)
- `number` - 数値 (整数と小数)
- `boolean` - 真偽値 (`true` または `false`)
- `table` - テーブル（配列・辞書）
- `function` - 関数
- `nil` - 値なし

### 2. テーブル（配列と辞書）

```lua
-- 配列のように使う
local list = { "apple", "banana", "orange" }
print(list[1])  -- "apple" (1始まり！)
print(#list)    -- 3 (要素数)

-- 辞書のように使う（キーバリュー）
local person = {
  name = "Alice",
  age = 30,
  email = "alice@example.com"
}
print(person.name)        -- "Alice"
print(person["age"])      -- 30

-- 混合型テーブル
local mixed = {
  "first",
  name = "Bob",
  10,
  { nested = true }
}

-- テーブルへの追加
table.insert(list, "grape")
list.new_field = "value"
list["key"] = 100
```

### 3. 制御フロー

```lua
-- if文
if x > 10 then
  print("xは10より大きい")
elseif x == 10 then
  print("xは10と等しい")
else
  print("xは10より小さい")
end

-- for ループ（数値）
for i = 1, 10 do
  print(i)
end

-- for ループ（テーブルイテレーション）
local items = { "a", "b", "c" }
for index, value in ipairs(items) do
  print(index, value)  -- 1 a, 2 b, 3 c
end

-- for ループ（辞書イテレーション）
local config = { name = "test", value = 10 }
for key, value in pairs(config) do
  print(key, value)
end

-- while ループ
local count = 0
while count < 5 do
  print(count)
  count = count + 1
end
```

### 4. 関数

```lua
-- 基本的な関数定義
local function greet(name)
  return "Hello, " .. name  -- ".." は文字列連結
end

print(greet("World"))  -- "Hello, World"

-- 複数の返り値
local function divide(a, b)
  if b == 0 then
    return nil, "ゼロで割ることはできません"
  end
  return a / b, nil
end

local result, error = divide(10, 2)

-- 無名関数
local add = function(a, b)
  return a + b
end

print(add(3, 5))  -- 8

-- 関数の引数がテーブルの場合
local function configure(opts)
  local name = opts.name or "default"
  local value = opts.value or 0
  return { name = name, value = value }
end

configure({ name = "test", value = 10 })
```

### 5. 文字列操作

```lua
-- 文字列連結
local str = "Hello" .. " " .. "World"

-- 文字列フォーマット（重要！）
local name = "Alice"
local age = 30
local message = string.format("My name is %s and I'm %d years old", name, age)

-- 文字列メソッド
local text = "hello world"
string.upper(text)      -- "HELLO WORLD"
string.lower(text)      -- "hello world"
string.sub(text, 1, 5)  -- "hello"
string.len(text)        -- 11

-- パターンマッチング
string.find("hello", "ll")  -- 3, 4（位置情報）
```

### 6. テーブル操作

```lua
-- テーブルの長さ
local t = { 1, 2, 3 }
print(#t)  -- 3

-- 要素の追加・削除
table.insert(t, 4)       -- 末尾に追加
table.insert(t, 2, 1.5)  -- インデックス2に1.5を挿入
table.remove(t, 2)       -- インデックス2を削除

-- テーブルの結合（簡易）
local t1 = { 1, 2 }
local t2 = { 3, 4 }
for _, v in ipairs(t2) do
  table.insert(t1, v)
end
-- t1は{1, 2, 3, 4}に

-- テーブルのコンテナのような使い方
local dict = {}
dict["key1"] = "value1"
dict.key2 = "value2"
```

---

## Neovimでの設定方法

### 1. Vimオプションの設定

Neovimでは、Vimの設定オプションを`vim.opt`で設定します。

```lua
-- vim.opt を使う方法（推奨）
vim.opt.number = true              -- 行番号表示
vim.opt.relativenumber = true      -- 相対行番号
vim.opt.tabstop = 4                -- タブ幅
vim.opt.shiftwidth = 4             -- インデント幅
vim.opt.expandtab = true           -- タブをスペースに変換
vim.opt.wrap = true                -- 長い行を折り返す
vim.opt.ignorecase = true          -- 検索時に大文字小文字を無視
vim.opt.smartcase = true           -- 大文字を含む場合は区別
vim.opt.scrolloff = 8              -- カーソル上下に8行の余白
vim.opt.cursorline = true          -- カーソル行をハイライト
vim.opt.mouse = "a"                -- マウス操作を有効化
vim.opt.clipboard = "unnamedplus"  -- システムクリップボード連携
vim.opt.termguicolors = true       -- 24ビットカラー
```

### 2. キーマッピング

キーボードショートカット（キーマップ）の設定は `lua/keymaps.lua` で行います。
具体的なキーマップの一覧は、リポジトリのルートにある以下のドキュメントを参照してください。

- **[keybinds.md](./keybinds.md)**

このファイルが、NeovimとWezTermのすべてのキーバインドに関する最新情報源です。

### 3. コマンド定義

```lua
-- カスタムコマンドの定義
vim.api.nvim_create_user_command('MyCommand', function(opts)
  print("Hello from custom command!")
end, { desc = "My custom command" })

-- 使用方法
-- :MyCommand
```

### 4. 自動コマンド

```lua
-- ファイル保存時に自動実行
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",  -- すべてのファイル
  callback = function()
    print("Saving file...")
  end
})

-- 複数のイベント
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.lua",
  callback = function()
    vim.opt.tabstop = 2
  end
})
```

### 5. グループ化と変数管理

```lua
-- グローバル設定
vim.g.mapleader = " "  -- リーダーキーを設定

-- グローバル変数
vim.g.my_custom_var = "value"

-- ウィンドウ設定
vim.w.option = true

-- バッファ設定
vim.b.option = false
```

---

## プラグイン管理（lazy.nvim）

### plugins.luaの構造

```lua
-- プラグインリストをテーブルで返す
return {
  -- シンプルなプラグイン（GitHubのrepo）
  "author/plugin-name",
  
  -- 複数の情報を持つプラグイン
  {
    "author/plugin-name",
    version = "*",              -- 最新メジャーバージョン
    event = "VeryLazy",         -- 遅延読み込み（起動時間短縮）
    dependencies = { "other/plugin" },  -- 依存関係
    config = function()
      require("plugin-name").setup({
        option1 = true,
        option2 = "value"
      })
    end
  },
  
  -- ビルドコマンド付き
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"  -- インストール後に実行
  }
}
```

### プラグインの遅延読み込み

```lua
{
  "nvim-lualine/lualine.nvim",
  event = "BufReadPost",  -- ファイル読み込み時に読み込み
  config = function()
    require("lualine").setup()
  end
}

-- event の種類
-- "VeryLazy"      - スタートアップの最後
-- "BufReadPost"   - ファイル読み込み後
-- "BufRead"       - ファイル読み込み時
-- "FileType"      - ファイルタイプ検出時
```

---

## 実践例

### 例1: キーマップの追加

```lua
-- keymaps.lua に追加
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ファイル保存
map("n", "<leader>w", ":w<CR>", opts)

-- 上下移動を高速化
map("n", "J", "5j", opts)
map("n", "K", "5k", opts)

-- 行頭・行末移動
map("n", "H", "^", opts)
map("n", "L", "$", opts)
```

### 例2: options.luaのカスタマイズ

```lua
-- Goプロジェクト用の設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = false  -- Goではタブを使う慣例
  end
})

-- JSON ファイル用の設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end
})
```

### 例3: LSP補完の設定

```lua
-- lsp.lua の一部
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})
```

### 例4: 新しいプラグインの追加

```lua
-- plugins.lua に追加
{
  "vim-test/vim-test",  -- テスト実行プラグイン
  lazy = true,
  config = function()
    vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { silent = true })
  end
}
```

その後、Neovimを再起動するか、以下を実行：
```
:Lazy sync
```

---

## 便利なVim/Neovimコマンド

```vim
:w              " ファイル保存
:q              " 終了
:wq             " 保存して終了
:set number     " 行番号表示
:set relativenumber  " 相対行番号表示
:Telescope find_files  " ファイル検索（Telescope）
:Lazy sync      " プラグイン同期（lazy.nvim）
:Mason          " LSPサーバー管理（Mason）
```

---

## デバッグのコツ

```lua
-- Luaコードのデバッグ出力
print(vim.inspect(variable))  -- テーブルをわかりやすく出力

-- エラーメッセージの確認
vim.notify("Message", vim.log.levels.INFO)  -- 通知表示

-- 設定の確認
:set option?   " オプション値の確認
:echo &number  " VimScript形式で確認
```

---

このマニュアルを参考に、Neovimの設定をカスタマイズしてください！
