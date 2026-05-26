**概要**

- WSL 上の Neovim で GitHub Copilot を使うための手順をまとめる。
- 現在の実装は `copilot.vim` ではなく `copilot.lua` + `CopilotChat.nvim` を使う構成。
- インストール作業は自分で行う前提で、必要なコマンドと確認ポイントを示す。

**前提**

- この手順は README の基本セットアップ完了後に実施してください: [../README.md](../README.md)

**前提（確認）**

- **Neovim**: `nvim --version` で最新の安定版を確認
- **Node.js**: `node -v` を確認（`copilot.lua` では Node.js 22.13 以上が必要）
- **Copilot アクセス権**: 個人または組織の Copilot サブスクリプションが必要

**インストール手順（WSL / Debian・Ubuntu 系の例）**

- Node.js を導入する場合は、22.13 以上を使う。既に NVM を使っているなら `~/.nvm/versions/node/v24.13.0/bin/node` のような新しい Node を指定できる。
- このリポジトリでは `wsl/nvim/lua/plugins/copilot.lua` 側で `copilot_node_command` を固定している。
- 初回認証は Copilot の device flow で行う。Neovim 側から認証を求められたら、ブラウザで案内されたコードを入力する。

```bash
node -v
```

**Neovim プラグイン側（既設定）**

- 参照ファイル: [wsl/nvim/lua/plugins/copilot.lua](wsl/nvim/lua/plugins/copilot.lua)
- `copilot.lua` の要点:
  - `lazy = false` で最初にセットアップ
  - `copilot_node_command` で Node.js の実体を固定
  - `suggestion.enabled = true` と `auto_trigger = true` で ghost text を有効化
  - `panel.enabled = false` でパネルを無効化
  - `<Tab>` は Copilot の提案を優先して確定し、`<C-n>` でも受諾できる
  - `<leader>co` で auto-trigger を ON/OFF
- `CopilotChat.nvim` の要点:
  - `model = "auto"`
  - 日本語の `system_prompt` を設定
  - `<leader>cc` でチャットペインを開閉
  - `window.layout = "vertical"` と `splitright = true` で右側に表示

**Neovim 側の同期とセットアップ**

1. Neovim を起動

```bash
nvim
```

2. lazy.nvim を使ってプラグイン同期（UI またはコマンド）:

```vim
:Lazy sync
```

3. ファイルを開いて挙動確認

- 挿入モードで Copilot の ghost text が出るか
- `<Tab>` で Copilot を優先確定できるか
- `<leader>cc` でチャットペインが開閉できるか

**よくあるトラブルと対処**

- `Node.js 22.13 is required...` が出る: `copilot_node_command` を 22.13 以上の Node に変える。
- `Model not found: gpt-4.1` / `gpt-4o` / `auto` が出る: `CopilotChat.nvim` の `model = "auto"` を使う。
- `Auth error: slow_down` が出る: device flow を短時間で何度も繰り返さず、少し待ってから再認証する。
- チャットペインが左に出る: `vim.opt.splitright = true` を確認する。

**カスタム設定例（キーを変えたい場合）**

- `wsl/nvim/lua/plugins/copilot.lua` の `keys` や `opts.mappings` を編集して好みのキーに変更してください。
- 例: Copilot の受諾キー、CopilotChat の `<leader>cc` など。

**補足**

- CLI ベースの Copilot はこの構成では必須ではない。
- 会社や組織のポリシーで Copilot が無効化されている場合は管理者に確認する。

**使い方（まとめ）**

- **Neovim（補完）**
  - 挿入モードで ghost text が表示される
  - 受諾: `<Tab>` または `<C-n>`
  - `<leader>co` で自動提案の ON/OFF を切替
- **Neovim（チャット）**
  - `<leader>cc` で CopilotChat を開閉
  - 右側にペインが出る

---

更新履歴: 2026-05-26 - copilot.lua / CopilotChat.nvim の現行構成に更新
