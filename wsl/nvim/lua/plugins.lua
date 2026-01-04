require("lazy").setup({

  -- ===== LSP =====
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- ===== 補完 =====
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- ===== Treesitter =====
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- ===== UI =====
  "nvim-lualine/lualine.nvim",
  "folke/which-key.nvim",
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  "akinsho/bufferline.nvim",

  -- ===== Telescope =====
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- ===== 編集支援 =====
  "numToStr/Comment.nvim",
  "kylechui/nvim-surround",
  "windwp/nvim-autopairs",

  -- ===== Git =====
  "lewis6991/gitsigns.nvim",
  "tpope/vim-fugitive",

  -- ===== その他 =====
  "folke/todo-comments.nvim",
  "goolord/alpha-nvim",

  -- ===== Theme =====
  "folke/tokyonight.nvim",
})

-- プラグイン初期化
vim.cmd.colorscheme("tokyonight")
require("lualine").setup()
require("which-key").setup()
require("bufferline").setup()
require("gitsigns").setup()
require("Comment").setup()
require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("todo-comments").setup()
