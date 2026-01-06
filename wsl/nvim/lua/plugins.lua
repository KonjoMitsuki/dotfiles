-- plugins.lua: Neovimプラグイン設定ファイル（lazy.nvim使用）

return {

  -- ===== LSP（Language Server Protocol） =====
  -- LSP設定のコアプラグイン
  "neovim/nvim-lspconfig",
  -- LSPサーバーのインストール・管理
  "williamboman/mason.nvim",
  -- masonとlspconfigの連携
  "williamboman/mason-lspconfig.nvim",

  -- ===== 補完（Completion） =====
  -- 補完エンジン
  "hrsh7th/nvim-cmp",
  -- LSPからの補完ソース
  "hrsh7th/cmp-nvim-lsp",
  -- スニペットエンジン
  "L3MON4D3/LuaSnip",
  -- LuaSnipとの連携
  "saadparwaiz1/cmp_luasnip",

  -- ===== Treesitter =====
  -- 構文ハイライトと解析（ビルドコマンド付き）
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- ===== UI（ユーザーインターフェース） =====
  -- ステータスライン
  "nvim-lualine/lualine.nvim",
  -- キーバインド表示
  "folke/which-key.nvim",
  -- ファイルツリー（依存関係付き）
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  -- バッファライン
  "akinsho/bufferline.nvim",

  -- ===== Telescope（ファジーファインダー） =====
  -- ファイル/テキスト検索
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- ===== 編集支援 =====
  -- コメント操作
  "numToStr/Comment.nvim",
  -- 囲み文字操作
  "kylechui/nvim-surround",
  -- 自動括弧補完
  "windwp/nvim-autopairs",

  -- ===== Git =====
  -- Git変更表示
  "lewis6991/gitsigns.nvim",
  -- Gitコマンド統合
  "tpope/vim-fugitive",

  -- ===== その他 =====
  -- TODOコメントハイライト
  "folke/todo-comments.nvim",
  -- スタート画面
  "goolord/alpha-nvim",

  -- ===== Theme（テーマ） =====
  -- Draculaカラースキーム
  "Mofiqul/dracula.nvim",
}

