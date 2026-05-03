-- テーマ・カラースキーム
return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        -- Neovim の背景を透過にする
        transparent = true,
        
        -- テーマのバリエーション（"wave", "dragon", "lotus" から選択可）
        theme = "wave",

        -- フローティングウィンドウの見た目を少し整える
        overrides = function(colors)
          return {
            Cursor = { fg = "black", bg = "white" },
            TermCursor = { fg = "black", bg = "white" },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            Floating = { bg = "none" },

            -- 必要なら行番号の背景も消せる
            -- LineNr = { bg = "none" },
          }
        end,
      })

      -- テーマを有効化する
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
