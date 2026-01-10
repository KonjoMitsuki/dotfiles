-- LSP関連プラグイン
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
      require("luasnip").setup()
    end,
  },
  -- Treesitter本体の設定を追加
-- wsl/nvim/lua/plugins/lsp.lua の treesitter 部分
-- wsl/nvim/lua/plugins/lsp.lua の treesitter 部分

-- wsl/nvim/lua/plugins/lsp.lua の treesitter 設定部分

-- wsl/nvim/lua/plugins/lsp.lua の treesitter 部分

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok or not configs then
        vim.notify("nvim-treesitter not found; skipping treesitter config", vim.log.levels.WARN)
        return
      end

      configs.setup({
        -- エラーの元凶である "vim" をインストールリストから外す
        ensure_installed = { "lua", "markdown", "markdown_inline" },
        
        -- 自動インストールも無効化
        auto_install = false,

        highlight = {
          enable = true,
          -- 【ここが重要】エラーが出ている "vim" 言語のハイライトを強制的にOFFにする
          disable = { "vim" }, 
        },
      })
    end,
  },
}
