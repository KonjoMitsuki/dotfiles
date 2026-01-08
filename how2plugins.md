# Neovim プラグイン集 — 機能と使い方（要点）

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
  - よく使うコマンド/ショートカット：
    - :LspInfo（LSP 状態確認）
    - :LspRestart（サーバ再起動）
    - キーマップ例（init で）:
      ```lua
      vim.keymap.set('n','gd',vim.lsp.buf.definition,{silent=true})
      vim.keymap.set('n','gr',vim.lsp.buf.references,{silent=true})
      vim.keymap.set('n','K',vim.lsp.buf.hover,{silent=true})
      vim.keymap.set('n','<leader>rn',vim.lsp.buf.rename,{silent=true})
      vim.keymap.set('n','<leader>ca',vim.lsp.buf.code_action,{silent=true})
      vim.keymap.set('n','<leader>f',function() vim.lsp.buf.format{async=true} end,{silent=true})
      ```

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
  - よく使うショートカット：
    - Ctrl-Space：補完メニューを開く
    - Enter：候補確定
    - Tab / Shift-Tab：スニペット移動（LuaSnip 設定に依存）

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
  - 便利なショートカット例：
    - folding を有効化して zc/zo で折りたたみ操作

- nvim-telescope/telescope.nvim
  - 役割：ファジーファインダー UI。
  - 最小設定例：
    ```lua
    require('telescope').setup{}
    ```
  - よく使うコマンド/ショートカット：
    - :Telescope find_files
    - :Telescope live_grep
    - :Telescope buffers
    - キーマップ例:
      ```lua
      vim.keymap.set('n','<leader>ff','<cmd>Telescope find_files<CR>',{silent=true})
      vim.keymap.set('n','<leader>fg','<cmd>Telescope live_grep<CR>',{silent=true})
      vim.keymap.set('n','<leader>fb','<cmd>Telescope buffers<CR>',{silent=true})
      ```

- nvim-tree/nvim-tree.lua
  - 役割：ファイルツリー表示。
  - 最小設定例：
    ```lua
    require('nvim-tree').setup{}
    ```
  - コマンド/ショートカット：
    - :NvimTreeToggle
    - :NvimTreeRefresh
    - キーマップ例: <Leader>e でトグル

- nvim-lualine/lualine.nvim / akinsho/bufferline.nvim / folke/which-key.nvim
  - 役割：ステータス/バッファ表示・キー案内。
  - 最小設定例：
    ```lua
    require('lualine').setup{}
    require('bufferline').setup{}
    require('which-key').setup{}
    ```
  - which-key 使い方：キーグループを登録して短いヒントを出せる（:WhichKey は不要、登録のみで表示される）

- lewis6991/gitsigns.nvim / tpope/vim-fugitive
  - 役割：行差分表示、Git 操作。
  - 最小設定例：
    ```lua
    require('gitsigns').setup{}
    ```
  - コマンド/ショートカット：
    - :G（fugitive）
    - gitsigns の例キー:
      ```lua
      vim.keymap.set('n','<leader>gh',require('gitsigns').next_hunk,{silent=true})
      vim.keymap.set('n','<leader>gH',require('gitsigns').prev_hunk,{silent=true})
      vim.keymap.set('n','<leader>gs',require('gitsigns').stage_hunk,{silent=true})
      vim.keymap.set('n','<leader>gr',require('gitsigns').reset_hunk,{silent=true})
      ```

- numToStr/Comment.nvim, kylechui/nvim-surround, windwp/nvim-autopairs
  - 役割：コメント / 囲み / 自動括弧。
  - 最小設定例：
    ```lua
    require('Comment').setup{}
    require('nvim-surround').setup{}
    require('nvim-autopairs').setup{}
    ```
  - よく使う操作：
    - gc + motion（例: gcj）でコメント切替（Comment.nvim）
    - ys, cs, ds で surround 操作（nvim-surround）
    - 自動で ( [ " などを補完（nvim-autopairs）

- folke/todo-comments.nvim, goolord/alpha-nvim, Mofiqul/dracula.nvim
  - 役割：TODOハイライト / スタート画面 / カラースキーム
  - 最小設定例：
    ```lua
    require('todo-comments').setup{}
    require('alpha').setup(require('alpha.themes.dashboard').config)
    vim.cmd('colorscheme dracula')
    ```
  - コマンド/ショートカット例：
    - :TodoQuickFix / :TodoLoclist / :TodoTelescope で TODO 検索
    - alpha は起動時に自動表示
    - colorscheme 切替は vim.cmd('colorscheme NAME')

## よく使うコマンド / キー（テーブル）
| プラグイン | よく使うコマンド / キー |
|---|---|
| neovim/nvim-lspconfig, mason | :LspInfo / :LspRestart / gd / gr / K / <leader>rn / <leader>ca / <leader>f |
| hrsh7th/nvim-cmp (+ LuaSnip) | Ctrl-Space / Enter / Tab / Shift-Tab |
| nvim-treesitter | :TSInstall <lang> / :TSUpdate / zc / zo |
| nvim-telescope (+ plenary) | :Telescope find_files / live_grep / buffers / <leader>ff / <leader>fg / <leader>fb |
| nvim-tree (+ web-devicons) | :NvimTreeToggle / :NvimTreeRefresh / <leader>e |
| nvim-lualine | ステータス自動表示 |
| akinsho/bufferline | バッファ切替（タブ表示） |
| folke/which-key | <leader> 系のヒント表示 |
| lewis6991/gitsigns | <leader>gh / <leader>gH / <leader>gs / <leader>gr |
| tpope/vim-fugitive | :G / :Gstatus / :Gblame 等 |
| numToStr/Comment.nvim | gc + motion（例: gcj） |
| kylechui/nvim-surround | ys / cs / ds 系コマンド |
| windwp/nvim-autopairs | 自動括弧・引用符補完 |
| folke/todo-comments | :TodoQuickFix / :TodoLoclist / :TodoTelescope |
| goolord/alpha-nvim | 起動時ダッシュボード（自動） |
| Mofiqul/dracula.nvim | vim.cmd('colorscheme dracula') |

4. 設定ファイルの分割例
- lua/plugins.lua : プラグイン一覧（既存）
- lua/plugin-config/<plugin>.lua : 個別設定を格納して plugins.lua の config で require する。

5. デバッグ／確認
- :Lazy でインストール状態確認、:checkhealth、:messages を参照。

6. 最小トラブルシュート
- プラグインが動かないとき：依存 (dependencies) と build コマンドを確認し、Neovim のバージョン/パスを確認する。

（必要であれば、各プラグインのより詳細なキーマップ/設定ファイル例を個別ファイルとして追記します。）
