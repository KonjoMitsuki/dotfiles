# Neovim プラグイン集 — 機能と使い方（要点）

**注意:** このドキュメントに記載されていたキーマップの例は、[keybinds.md](./keybinds.md) に集約されました。最新のキーボードショートカットについては、そちらを参照してください。

目的：lazy.nvim で管理する主要プラグインの役割と最小限の設定例／使い方をまとめる。

1. インストール（lazy.nvim）
- 基本：require('lazy').setup(require('plugins')) を init.lua で呼ぶ。
- プラグイン定義の例：
  { "repo/name", config = function() require('xx').setup({}) end, dependencies = {...}, build = "..." }

2. 遅延読み込みのヒント
- オプション：event, cmd, ft, keys, lazy = true, dependencies を使って起動時間を削る。

3. 主要プラグイン（短い説明と使い方）
- neovim/nvim-lspconfig + williamboman/mason.nvim / mason-lspconfig
  - 役割：LSP のインストールと接続。
  - 最小設定例：
    ```lua
    require('mason').setup()
    require('mason-lspconfig').setup()
    require('lspconfig').pyright.setup{}
    ```
  - よく使うコマンド：
    - :LspInfo（LSP 状態確認）
    - :LspRestart（サーバ再起動）

- hrsh7th/nvim-cmp (+ cmp-nvim-lsp, LuaSnip, cmp_luasnip)
  - 役割：補完・スニペット。
  - 最小設定例：
    ```lua
    local cmp = require('cmp')
    cmp.setup{
      sources = { {name='nvim_lsp'}, {name='luasnip'} },
      mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }
    }
    ```

- nvim-treesitter/nvim-treesitter
  - 役割：構文解析・高品質ハイライト。
  - 最小設定例：
    ```lua
    require('nvim-treesitter.configs').setup{
      ensure_installed = {"c","cpp","python","lua"},
      highlight = { enable = true },
    }
    ```
  - コマンド：
    - :TSInstall <lang>
    - :TSUpdate

- nvim-telescope/telescope.nvim
  - 役割：ファジーファインダー UI。
  - 最小設定例：
    ```lua
    require('telescope').setup{}
    ```
  - よく使うコマンド：
    - :Telescope find_files
    - :Telescope live_grep
    - :Telescope buffers

- nvim-tree/nvim-tree.lua
  - 役割：ファイルツリー表示。
  - 最小設定例：
    ```lua
    require('nvim-tree').setup{}
    ```
  - コマンド：
    - :NvimTreeToggle
    - :NvimTreeRefresh

- nvim-lualine/lualine.nvim / akinsho/bufferline.nvim / folke/which-key.nvim
  - 役割：ステータス/バッファ表示・キー案内。
  - 最小設定例：
    ```lua
    require('lualine').setup{}
    require('bufferline').setup{}
    require('which-key').setup{}
    ```

- lewis6991/gitsigns.nvim / tpope/vim-fugitive
  - 役割：行差分表示、Git 操作。
  - 最小設定例：
    ```lua
    require('gitsigns').setup{}
    ```
  - コマンド：
    - :G（fugitive）

- numToStr/Comment.nvim, kylechui/nvim-surround, windwp/nvim-autopairs
  - 役割：コメント / 囲み / 自動括弧。
  - 最小設定例：
    ```lua
    require('Comment').setup{}
    require('nvim-surround').setup{}
    require('nvim-autopairs').setup{}
    ```

- folke/todo-comments.nvim, goolord/alpha-nvim, Mofiqul/dracula.nvim
  - 役割：TODOハイライト / スタート画面 / カラースキーム
  - 最小設定例：
    ```lua
    require('todo-comments').setup{}
    require('alpha').setup(require('alpha.themes.dashboard').config)
    vim.cmd('colorscheme dracula')
    ```
  - コマンド：
    - :TodoQuickFix / :TodoLoclist / :TodoTelescope で TODO 検索

4. 設定ファイルの分割例
- lua/plugins.lua : プラグイン一覧（既存）
- lua/plugin-config/<plugin>.lua : 個別設定を格納して plugins.lua の config で require する。

5. デバッグ／確認
- :Lazy でインストール状態確認、:checkhealth、:messages を参照。

6. 最小トラブルシュート
- プラグインが動かないとき：依存 (dependencies) と build コマンドを確認し、Neovim のバージョン/パスを確認する。
