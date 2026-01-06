-- lua/lsp.lua
local lspconfig = require('lspconfig')

-- 例: インストールしたサーバーの設定をここに追加
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enterで決定
    ['<Tab>'] = cmp.mapping.select_next_item(),        -- Tabで次を選択
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),    -- Shift+Tabで前を選択
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSPからの補完
    { name = 'luasnip' },  -- スニペット
  }, {
    { name = 'buffer' },   -- ファイル内の単語
  })
})
-- 必要に応じて、LSP起動時のみ有効にしたいキーマップなどもここに記述できます
