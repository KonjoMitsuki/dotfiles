-- Copilot（Luaネイティブ） + CopilotChat 用の lazy.nvim プラグイン設定
return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = { "Copilot" },
        keys = {
            {
                "<leader>co",
                function()
                    local suggestion = require("copilot.suggestion")
                    vim.g.copilot_auto_trigger_enabled = vim.g.copilot_auto_trigger_enabled
                        or true
                    suggestion.toggle_auto_trigger()
                    vim.g.copilot_auto_trigger_enabled = not vim.g.copilot_auto_trigger_enabled

                    local status = vim.g.copilot_auto_trigger_enabled and "enabled" or "disabled"
                    vim.notify("Copilot suggestion: " .. status, vim.log.levels.INFO)
                end,
                mode = "n",
                desc = "Toggle Copilot suggestion",
            },
        },
        opts = {
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<C-n>",
                },
            },
        },
        config = function(_, opts)
            require("copilot").setup(opts)
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            "zbirenbaum/copilot.lua",
            "nvim-lua/plenary.nvim",
        },
        opts = {
            debug = false,
            window = {
                layout = "vertical",
                width = 0.5,
            },
            system_prompt = [[
            あなたは経験豊富な日本人のシニアプログラマーです。
            以下のルールに従って回答してください：
            1. すべての説明は日本語で行う
            2. コード内のコメントも日本語で記述する
            3. 技術用語は必要に応じて英語併記する
            4. コードは実践的で本番環境で使用できる品質にする
            5. ベストプラクティスとデザインパターンを適用する  
        ]],
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
        },
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<CR>", mode = "n", desc = "Toggle Copilot Chat" },
        },
    },
}
