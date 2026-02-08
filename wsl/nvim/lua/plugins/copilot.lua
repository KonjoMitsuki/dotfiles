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
        
        -- Copilotトグル機能
        local copilot_enabled = true
        vim.keymap.set("n", "<leader>co", function()
            copilot_enabled = not copilot_enabled
            if copilot_enabled then
                vim.cmd("Copilot enable")
                vim.notify("Copilot: enabled", vim.log.levels.INFO)
            else
                vim.cmd("Copilot disable")
                vim.notify("Copilot: disabled", vim.log.levels.INFO)
            end
        end, { desc = "Toggle Copilot" })
        end,
    },
}
