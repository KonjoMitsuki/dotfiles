-- UI関連プラグイン
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
      require("oil").setup({
        -- 例: 隠しファイルを表示
        view_options = { show_hidden = true },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
	    if not vim.g.vscode then
	      require("ibl").setup({
		indent = { char = "│" },
	      })
	    end
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      require("toggleterm").setup({
        size = 20,
        direction = "horizontal",
        float_opts = { border = "curved", winblend = 3 },
      })

      -- lazygit の設定を追加
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
      })

      local function _lazygit_toggle()
        lazygit:toggle()
      end
      vim.keymap.set("n", "<leader>lg", _lazygit_toggle, { noremap = true, silent = true, desc = "Toggle Lazygit" })      
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- 記事にあるリッチな通知に必要
    },
    config = function()
      local noice = require("noice")
      
      -- 記事で紹介されている、特定のメッセージを画面右下(mini)に表示するヘルパー関数
      local function myMiniView(pattern, kind)
        kind = kind or ""
        return {
          view = "mini",
          filter = {
            event = "msg_show",
            kind = kind,
            find = pattern,
          },
        }
      end

      noice.setup({
        -- 検索( / や ? )の表示を画面右下に設定
        messages = {
          view_search = "mini",
        },
        -- 記事に基づいたフィルタリング設定 (routes)
        routes = {
          -- モード表示(INSERT等)をnotifyビューへ
          { 
            view = "notify", 
            filter = { event = "msg_showmode" } 
          },
          -- 記事で myMiniView を使って定義されている、控えめに表示したい通知群
          myMiniView("Already at .* change"),
          myMiniView("written"),
          myMiniView("yanked"),
          myMiniView("more lines?"),
          myMiniView("fewer lines?"),
          myMiniView("fewer lines?", "lua_error"),
          myMiniView("change; before"),
          myMiniView("change; after"),
          myMiniView("line less"),
          myMiniView("lines indented"),
          myMiniView("No lines in buffer"),
          myMiniView("search hit .*, continuing at", "wmsg"),
          myMiniView("E486: Pattern not found", "emsg"),
        },
        -- デフォルトのプリセット
        presets = {
          bottom_search = true,    -- 下部検索
          command_palette = true,  -- コマンドパレットを中央に
          long_message_to_split = true,
        },
      })
    end,
  },
}
