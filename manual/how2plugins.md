# Neovim プラグイン集 — 機能と使い方（要点）

このドキュメントは README のセットアップ完了後に参照してください。

- セットアップ手順: [../README.md](../README.md)
- キーバインド一覧: [keybinds.md](./keybinds.md)

目的: lazy.nvim の使い方（要点）と、現在導入中プラグイン一覧を同じページで確認できるようにする。

## 1. インストールと読み込み

- 基本: `require("lazy").setup(require("plugins"))` を `init.lua` で呼ぶ。
- 実体: `wsl/nvim/lua/plugins.lua`
- `wsl/nvim/lua/plugins/*.lua` を自動走査して全specを結合する構成。

## 2. 遅延読み込みのコツ

- 主に `event`, `cmd`, `dependencies`, `build` を使って起動時間を抑える。
- 例:
  - `event = "InsertEnter"`: 挿入モードに入ったときに読み込む
  - `cmd = "Telescope"`: コマンド実行時に読み込む
  - `build = ":TSUpdate"`: インストール後処理を実行する

## 3. よく使う操作

- `:Lazy` インストール状態の確認
- `:Lazy sync` 同期
- `:checkhealth` 依存と環境の診断
- `:messages` エラーログ確認

## 4. トラブルシュート最小セット

- 起動しない/読み込まれない場合:
  - `:Lazy` で対象プラグインの状態を確認
  - `dependencies` の不足がないか確認
  - `build` が必要なプラグイン（Treesitter/Masonなど）を再実行
  - Neovim のバージョンとPATHを確認

## 5. 現在導入中プラグイン一覧（実装ベース）

参照元は `wsl/nvim/lua/plugins.lua` および `wsl/nvim/lua/plugins/*.lua`。

### UI系 (`wsl/nvim/lua/plugins/ui.lua`)

- `nvim-lualine/lualine.nvim`
  - 説明: 画面下部のステータスラインを見やすく表示する。
  - 使い方: ステータスラインにモード/ファイル/Git状態を表示。通常操作で常時有効。
- `folke/which-key.nvim`
  - 説明: キー入力の候補をポップアップ表示して操作を補助する。
  - 使い方: Leader キー押下後に候補を表示。キーを忘れたときのガイドとして使う。
- `akinsho/bufferline.nvim`
  - 説明: 開いているバッファをタブのように見える形で管理する。
  - 使い方: バッファ一覧をタブ風に表示。`<Leader>bn` / `<Leader>bp` / `<Leader>bd` で移動・削除。
- `nvim-tree/nvim-tree.lua`
  - 説明: サイドバー型のファイルツリーを表示する。
  - 使い方: `:NvimTreeToggle` または `<Leader>e` でファイルツリーを開閉。
- `stevearc/oil.nvim`
  - 説明: バッファ上でディレクトリを編集できるファイルマネージャー。
  - 使い方: `:Oil` または `<Leader>o` でファイルマネージャーを開く。
- `nvim-telescope/telescope.nvim`
  - 説明: ファイル/文字列/バッファを高速検索するファジーファインダー。
  - 使い方: `:Telescope find_files` / `live_grep` / `buffers`。
  - キー: `<Leader>ff` / `<Leader>fg` / `<Leader>fb`。
- `lukas-reineke/indent-blankline.nvim`
  - 説明: インデント深さをガイド線で可視化する。
  - 使い方: インデントガイドを表示してネストを見やすくする（自動有効）。
- `akinsho/toggleterm.nvim`
  - 説明: Neovim 内でターミナルを開閉できるようにする。
  - 使い方: `:ToggleTerm` または `<Leader>t` で内蔵ターミナルを開閉。
  - 補足: `<Leader>lg` で lazygit 用フローティング端末をトグル。
- `goolord/alpha-nvim`
  - 説明: 起動時のダッシュボード画面を提供する。
  - 使い方: Neovim 起動時のダッシュボード画面を表示（`VimEnter` で自動）。
- `folke/noice.nvim`
  - 説明: メッセージ表示やコマンドラインUIを強化する。
  - 使い方: メッセージ/通知UIを改善。`<Leader>nd` または Insert の `<C-\><C-\>` で通知を閉じる。

### 編集支援 (`wsl/nvim/lua/plugins/editor.lua`)

- `numToStr/Comment.nvim`
  - 説明: コメントのON/OFFを素早く切り替える。
  - 使い方: コメント切替。`<C-/>`（端末によっては `<C-_>`）でトグル。
- `kylechui/nvim-surround`
  - 説明: 文字列や範囲を括弧/引用符などで囲む操作を効率化する。
  - 使い方: 文字列囲みの追加/変更/削除。`ys` / `cs` / `ds` を使用。
- `windwp/nvim-autopairs`
  - 説明: 括弧・クォートの閉じ文字を自動補完する。
  - 使い方: `(` `{` `[` などの閉じ括弧を自動挿入（InsertEnter 後に有効）。
- `folke/todo-comments.nvim`
  - 説明: TODO/FIX などの注釈コメントを目立たせる。
  - 使い方: `TODO` `FIX` などを強調表示。必要なら `:TodoQuickFix` で一覧化。

### Git系 (`wsl/nvim/lua/plugins/git.lua`)

- `lewis6991/gitsigns.nvim`
  - 説明: Git差分を行単位で表示して変更箇所を把握しやすくする。
  - 使い方: 行の追加/変更/削除をサイン列に表示（通常編集で自動反映）。
- `tpope/vim-fugitive`
  - 説明: Neovim内でGit操作を行うための定番プラグイン。
  - 使い方: `:Git` または `<Leader>gs` で Git 画面を開く。

### LSP/補完/構文解析 (`wsl/nvim/lua/plugins/lsp.lua`)

- `neovim/nvim-lspconfig`
  - 説明: 各言語サーバーとの接続設定を提供する。
  - 使い方: LSP接続を提供。`<Leader>ca` で Code Action、`<Leader>k` で Hover。
- `williamboman/mason.nvim`
  - 説明: LSP/formatter/linter など外部ツールのインストール管理を行う。
  - 使い方: `:Mason` / `:MasonInstall <server>` でLSPサーバ管理。
- `williamboman/mason-lspconfig.nvim`
  - 説明: Mason と lspconfig の橋渡しをして設定を簡略化する。
  - 使い方: Mason で入れたサーバを lspconfig 連携して自動設定。
- `hrsh7th/nvim-cmp`
  - 説明: 補完候補を表示・選択する補完UI本体。
  - 使い方: 補完UI。`<C-Space>` で候補表示、`<Tab>` で確定。
- `hrsh7th/cmp-nvim-lsp` (dependency)
  - 説明: LSPから補完候補を受け取るための補助ソース。
  - 使い方: LSP補完ソースを nvim-cmp に接続（直接操作なし）。
- `saadparwaiz1/cmp_luasnip` (dependency)
  - 説明: LuaSnipの候補を nvim-cmp に流し込む補助ソース。
  - 使い方: LuaSnip の補完候補を nvim-cmp に接続（直接操作なし）。
- `L3MON4D3/LuaSnip`
  - 説明: スニペット定義と展開を担うエンジン。
  - 使い方: スニペット展開基盤（nvim-cmp 経由で使用）。
- `nvim-treesitter/nvim-treesitter`
  - 説明: 構文木ベースでハイライトや解析精度を上げる。
  - 使い方: 高精度ハイライト/構文解析。`:TSUpdate` でパーサ更新。

### テーマ (`wsl/nvim/lua/plugins/theme.lua`)

- `rebelot/kanagawa.nvim`
  - 説明: Kanagawa テーマを提供するカラースキーム。
  - 使い方: 起動時に `colorscheme kanagawa` を自動適用。

### AI (`wsl/nvim/lua/plugins/copilot.lua`)

- `zbirenbaum/copilot.lua`
  - 説明: GitHub Copilot の補完本体。Lua ネイティブで動く。
  - 使い方: Insert モードで ghost text を表示。`<Tab>` で Copilot 提案を優先確定し、`<C-n>` でも受諾できる。
  - 補足: `copilot_node_command` で Node.js 22.13 以上を指定し、`panel = false` でパネルを無効化している。
  - キー: `<Leader>co` で auto-trigger を切替。
- `CopilotC-Nvim/CopilotChat.nvim`
  - 説明: GitHub Copilot のチャット機能を提供する。
  - 使い方: `<Leader>cc` でチャットペインを開閉。
  - 補足: `model = "auto"` と日本語の `system_prompt` を設定している。

## 間接依存として使用している主なプラグイン

- `nvim-tree/nvim-web-devicons`
- `nvim-lua/plenary.nvim`
- `MunifTanjim/nui.nvim`
- `rcarriga/nvim-notify`
