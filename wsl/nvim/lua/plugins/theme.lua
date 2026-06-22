return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
        overrides = {
          -- 1. 組み込み型 (int, bool, void) を鮮やかなオレンジに
          ["@type.builtin"] = { fg = "#fe8019", bold = true },

          -- 2. クラス名・ユーザー定義型・標準ライブラリ型 (HashSeparate, map, string) を黄色に
          ["@type"] = { fg = "#fabd2f", bold = true },
          ["@lsp.type.class"] = { link = "@type" },
          ["@lsp.type.struct"] = { link = "@type" },
          ["@lsp.type.type"] = { link = "@type" },
          ["@lsp.type.enum"] = { link = "@type" },

          -- 3. 関数・メソッド名 (Find, hash, find, empty, begin, end) を黄緑色に
          ["@function"] = { fg = "#b8bb26", bold = true },
          ["@function.call"] = { fg = "#b8bb26", bold = true },
          ["@method"] = { fg = "#b8bb26", bold = true },
          ["@method.call"] = { fg = "#b8bb26", bold = true },
          ["@lsp.type.function"] = { link = "@function" },
          ["@lsp.type.method"] = { link = "@function" },

          -- 4. 制御構文や修飾子 (if, else, for, return, const) を赤色に
          ["@keyword"] = { fg = "#fb4934" },
          ["@keyword.return"] = { fg = "#fb4934", bold = true },
          ["@keyword.modifier"] = { fg = "#fb4934" }, -- const用
          ["@lsp.type.modifier"] = { link = "@keyword.modifier" },

          -- 5. 標準入出力オブジェクト (cout, endl) や 参照記号 (&) を水色に
          ["@variable.builtin"] = { fg = "#8ec07c" }, -- cout, endl など
          ["@operator"] = { fg = "#ebdbb2" },        -- 通常の演算子 (=, ->) はグレー
          -- C++の参照記号 (&) を水色にするためのTreesitter固有設定
          ["@operator.cpp"] = { fg = "#8ec07c" }, 
        }
      })
      vim.cmd("colorscheme gruvbox")
    end,
  }
}
