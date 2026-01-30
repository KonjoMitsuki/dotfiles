-- Copilot（GitHub Copilot for Vim/Neovim）用の lazy.nvim プラグイン設定
return {
    {
        "github/copilot.vim",
        event = "InsertEnter",
        cmd = { "Copilot" },
        config = function()
        -- デフォルトの <Tab> 受諾を無効化し、独自の受諾キーを割り当てる
        vim.g.copilot_no_tab_map = true
        vim.keymap.set("i", "<C-J>", 'copilot#Accept("")', { expr = true, silent = true, replace_keycodes = false, desc = "Copilot accept" })
        vim.keymap.set("n", "<leader>co", "<cmd>Copilot<cr>", { desc = "Open Copilot" })
        end,
    },
}
