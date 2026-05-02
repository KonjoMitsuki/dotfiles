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
            copilot_node_command = "-- "copilot_node_command = vim.fn.exepath("node"),",
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

            -- Avante互換: hosts.json/apps.json が無ければ CopilotChat の保存トークンから復元
            local uv = vim.uv or vim.loop
            local config_root = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":h")
            local copilot_dir = config_root .. "/github-copilot"
            local hosts_path = copilot_dir .. "/hosts.json"
            local apps_path = copilot_dir .. "/apps.json"

            if uv.fs_stat(hosts_path) or uv.fs_stat(apps_path) then
                return
            end

            local token_path = vim.fn.stdpath("data") .. "/copilot_chat/tokens.json"
            local token_file = io.open(token_path, "r")
            if not token_file then
                return
            end

            local token_json = token_file:read("*a")
            token_file:close()

            local ok, decoded = pcall(vim.json.decode, token_json)
            local token = ok and decoded and decoded.github_copilot or nil
            if not token then
                return
            end

            vim.fn.mkdir(copilot_dir, "p")
            local payload = vim.json.encode({
                ["github.com"] = {
                    oauth_token = token,
                },
            })

            for _, out_path in ipairs({ hosts_path, apps_path }) do
                local f = io.open(out_path, "w")
                if f then
                    f:write(payload)
                    f:close()
                    pcall(vim.fn.setfperm, out_path, "rw-------")
                end
            end
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

    -- 3. Avante (Agentモード) の設定
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, 
        opts = {
            provider = "copilot", -- GitHub Copilotを利用
            auto_apply_diff_after_generation = false, 
            mappings = {
                ask = "<leader>av",
                edit = "<leader>aE",
                refresh = "<leader>ar",
                toggle = {
                    default = "<leader>at",
                },
            },
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "zbirenbaum/copilot.lua",
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                    },
                },
            },
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
