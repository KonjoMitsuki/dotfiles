return {
    -- 1. Copilot本体の設定
    {
        "zbirenbaum/copilot.lua",
        -- ↓ 【完全解決の修正】キー入力待ちをキャンセルし、Neovim起動時に一番最初にセットアップさせる
        lazy = false, 
        keys = {
            {
                "<leader>co",
                function()
                    local suggestion = require("copilot.suggestion")
                    vim.g.copilot_auto_trigger_enabled = vim.g.copilot_auto_trigger_enabled or true
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
            -- node"コマンドの絶対パスを環境に合わせて動的に取得する
            copilot_node_command = vim.fn.exepath("node"),
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

    -- 2. CopilotChatの設定
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            "zbirenbaum/copilot.lua",
            "nvim-lua/plenary.nvim",
        },
        cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain", "CopilotChatFix" },
        opts = {
            debug = false,
            model = "auto",
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
