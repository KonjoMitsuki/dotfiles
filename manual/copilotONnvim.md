**概要**
- WSL 上の Neovim で GitHub Copilot（CLI と `copilot.vim`）を使うための手順をまとめる。インストール作業は自分で行う前提で、必要なコマンドと確認ポイントを示す。

**前提（確認）**
- **Neovim**: `nvim --version` で最新の安定版（推奨: 0.8 以上または配布の最新パッチ）を確認
- **Node.js / npm**: `node -v` `npm -v`（Copilot.vim の node provider / CLI が必要）
- **Copilot アクセス権**: 個人または組織の Copilot サブスクリプションが必要

**インストール手順（WSL / Debian・Ubuntu 系の例）**

- Node.js を導入（18 系の例）:

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs build-essential
```

- Copilot CLI をインストール（推奨: install スクリプト）:

```bash
curl -fsSL https://gh.io/copilot-install | bash
# 代替: npm 経由
# npm install -g @github/copilot
```

- Copilot CLI を認証（対話式）:

```bash
copilot
# 起動後に '/login' を実行してブラウザで認証フローに従う
```

- 又は PAT を使う（Fine-grained Token、権限: "Copilot Requests"）:　上の認証をやればこちらはやらなくていい

1. https://github.com/settings/personal-access-tokens/new でトークンを作成
2. シェルに環境変数を設定:

```bash
echo 'export GH_TOKEN="YOUR_TOKEN_HERE"' >> ~/.bashrc
source ~/.bashrc
```

**Neovim プラグイン側（既設定）**
- 既に `copilot.vim` の lazy.nvim 用プラグイン仕様を追加済み: [wsl/nvim/lua/plugins/copilot.lua](wsl/nvim/lua/plugins/copilot.lua)
- 追加内容の要点:
	- `event = "InsertEnter"` で挿入開始時に読み込み
	- `cmd = { "Copilot", "CopilotSetup" }` でコマンドを遅延読み込み
	- `vim.g.copilot_no_tab_map = true` によりデフォルトの `<Tab>` 受諾を無効化
	- 受諾キーを `Ctrl-J` に割当（`copilot#Accept("\r")`）
	- ノーマルモードで `:Copilot` を開くためのショートカットを `<leader>co` に設定

**Neovim 側の同期とセットアップ**

1. Neovim を起動

```bash
nvim
```

2. lazy.nvim を使ってプラグイン同期（UI またはコマンド）:

```vim
:Lazy sync
```

3. Copilot のセットアップを実行:

```vim
:Copilot setup
```

4. ファイルを開いて挙動確認（挿入モードで補完候補が出るか、`Ctrl-J` で受諾できるか）

**よくあるトラブルと対処**
- `copilot` コマンドが見つからない: PATH を確認。インストール先が `~/.local/bin` の場合は `~/.local/bin` を `PATH` に追加。
- Neovim の node provider が無い/エラー: `:checkhealth` を実行して `node` 関連の問題を確認。
- 認証エラー: CLI 起動後に `/login` を再試行、または `GH_TOKEN` を正しくエクスポートしているか確認。
- プラグインが読み込まれない: `:messages` や `:Lazy log` を確認し、`~/.local/share/nvim/lazy` 以下に `copilot.vim` が存在するか確認。

**カスタム設定例（受諾キーを変えたい場合）**
- `wsl/nvim/lua/plugins/copilot.lua` の `vim.keymap.set` を編集して好みのキーに変更してください（例: `"<C-Space>"` など）。

**補足**
- CLI を使うとターミナル内で Copilot の会話型操作やリポジトリコンテキストを利用できるため、併用を推奨。
- 会社や組織のポリシーで Copilot が無効化されている場合は管理者に確認してください。

**使い方（まとめ）**
- **Neovim（補完）**
	- 挿入モードで補完候補が表示される
	- 受諾: `Ctrl-J`（本設定のカスタムマップ）
	- その他の操作は `:help copilot` を参照
- **Neovim（コマンド）**
	- 設定ウィザード: `:Copilot setup`
	- ステータス/操作: `:Copilot` または `<leader>co`
- **CLI**
	- 起動: `copilot`
	- 終了: `/exit` または `Ctrl-D`
	- 初回認証: `/login`
	- よく使うコマンド:
		- `/help` - コマンド一覧とヘルプ
		- `/model` - 使用するモデルの選択（Claude Sonnet 4.5、GPT-4 など）
		- `/feedback` - フィードバック送信
		- `/clear` - 会話履歴をクリア
		- `/context` - 現在のコンテキスト情報を表示
	- モデル/設定の詳細は CLI の `/help` を参照

---
更新履歴: 2026-01-29 - 初版（WSL + Neovim 向け手順）
