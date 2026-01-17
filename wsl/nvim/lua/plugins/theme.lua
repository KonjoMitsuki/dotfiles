-- テーマ・カラースキーム
return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        -- ここを true にすると Neovim の背景色が消え、WezTerm の半透明背景が見えるようになります
        transparent = true,
        
        -- テーマのバリエーション（"wave", "dragon", "lotus" から選択可）
        theme = "wave",

        -- 必要に応じて、フローティングウィンドウなどの背景も消す上書き設定
        overrides = function(colors)
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            Floating = { bg = "none" },
            
            -- 行番号の背景を消したい場合（transparent=trueなら基本不要ですが念のため）
            -- LineNr = { bg = "none" },
          }
        end,
      })
      
      -- 設定を適用
      vim.cmd("colorscheme kanagawa")
    end,
  },
}