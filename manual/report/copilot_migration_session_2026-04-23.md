# Neovim Copilot移行記: copilot.vim から copilot.lua + CopilotChat + Avante へ

更新日: 2026-04-23  
対象リポジトリ: /home/siiiron/dotfiles

## はじめに

このエントリは、Neovim の Copilot 環境を段階的に移行したときの実録です。  
単なる「設定の貼り付け」ではなく、実際にハマったポイントと、その場でどう直したかを時系列でまとめています。

今回のゴールは次の3つでした。

1. 補完を github/copilot.vim から zbirenbaum/copilot.lua に移す
2. チャット機能として CopilotChat.nvim を追加する
3. Avante 連携まで通して、日常運用で詰まらない状態にする

## この記事の読者

- Neovim で Copilot を本格運用したい人
- CopilotChat / Avante を同時に使いたい人
- 「Model not found」や「exit code 24」などの実行時エラーで止まった人

## 最終的に採用した構成

### プラグイン

- 補完: zbirenbaum/copilot.lua
- チャット: CopilotC-Nvim/CopilotChat.nvim
- エージェント: yetone/avante.nvim

### キー

- Copilot 自動提案トグル: <leader>co
- CopilotChat 開閉: <leader>cc
- Avante ask: <leader>av
- Avante edit: <leader>aE
- Avante refresh: <leader>ar
- Avante toggle: <leader>at

### 補完確定の方針

- cmp の確定キーは Tab のまま維持
- Tab 押下時に Copilot の ghost text が見えていれば Copilot を優先確定

## なぜ移行したか

従来の copilot.vim でも補完自体は動作しますが、今回の運用要件では次の点が不足していました。

- Lua ネイティブな柔軟性
- CopilotChat との自然な共存
- Avante との接続時に必要な認証ファイル管理
- cmp と競合しにくい補完制御

copilot.lua に寄せることで、挙動の制御点を明確に持てるようになります。

## 実装手順（時系列）

### Step 1: copilot.vim から copilot.lua へ置換

最初に plugins 定義を置き換えました。

- github/copilot.vim を削除
- zbirenbaum/copilot.lua を追加
- suggestion.enabled = true
- suggestion.auto_trigger = true
- panel.enabled = false

同時に <leader>co を copilot.suggestion.toggle_auto_trigger() で切り替える設計に変更。

### Step 2: CopilotChat を追加

CopilotChat.nvim を導入し、次を設定しました。

- 日本語の system_prompt
- <leader>cc で開閉
- model は最終的に auto を採用

### Step 3: cmp と Copilot の Tab 優先順位調整

補完キーはユーザー要望に合わせて調整。

- 一度は <C-n> 運用へ変更
- その後「cmp は Tab のままで良い」に戻した
- 最終は Tab で「Copilot優先 -> cmp確定 -> 通常Tab」の順

### Step 4: チャットペインを右側固定

CopilotChat の vertical split は Neovim の splitright 設定に従うため、次を適用。

```lua
vim.opt.splitright = true
```

これでチャットが右側に表示されるようになりました。

## 実装コードの詳細解説（ファイル別）

ここからは、実際にこのセッションで書いたコードをファイル単位で分解して解説します。

### 1. wsl/nvim/lua/plugins/copilot.lua

このファイルが今回の主戦場でした。役割は次の3つです。

1. Copilot 補完の初期化
2. CopilotChat の初期化
3. Avante の初期化

#### 1-1. Copilot プラグイン定義

要点は lazy = false です。

```lua
{
	"zbirenbaum/copilot.lua",
	lazy = false,
	...
}
```

これにより、InsertEnter を待たずに起動直後から setup が確実に走るようにしています。  
Avante 側が Copilot の準備状態を参照するため、初期化順の安定化は重要でした。

#### 1-2. <leader>co のトグル実装

```lua
vim.keymap.set("n", "<leader>co", function()
	local suggestion = require("copilot.suggestion")
	vim.g.copilot_auto_trigger_enabled = vim.g.copilot_auto_trigger_enabled or true
	suggestion.toggle_auto_trigger()
	vim.g.copilot_auto_trigger_enabled = not vim.g.copilot_auto_trigger_enabled

	local status = vim.g.copilot_auto_trigger_enabled and "enabled" or "disabled"
	vim.notify("Copilot suggestion: " .. status, vim.log.levels.INFO)
end)
```

設計のポイント:

- 以前は is_auto_trigger() を呼んでいたが、API が存在せず落ちた
- そのため「トグル自体は公式API」「表示状態はグローバル変数で管理」に分離
- notify で状態を可視化し、トグル結果が不透明にならないようにした

#### 1-3. Copilot の本体オプション

```lua
opts = {
	copilot_node_command = "/home/siiiron/.nvm/versions/node/v24.13.0/bin/node",
	panel = { enabled = false },
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = { accept = "<C-n>" },
	},
}
```

それぞれの意味:

- copilot_node_command:
  - Copilot LSP が使う Node 実行ファイルを固定
  - exit code 24 の根本原因（22.12.0）を回避
- panel.enabled = false:
  - 別UIとの競合を避ける
- suggestion:
  - ghost text を常時使うための最小セット

#### 1-4. Avante 互換の自動復元ロジック

最も重要な再発防止コードです。

```lua
local config_root = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":h")
local copilot_dir = config_root .. "/github-copilot"
local hosts_path = copilot_dir .. "/hosts.json"
local apps_path = copilot_dir .. "/apps.json"

if uv.fs_stat(hosts_path) or uv.fs_stat(apps_path) then
	return
end

local token_path = vim.fn.stdpath("data") .. "/copilot_chat/tokens.json"
local token_file = io.open(token_path, "r")
...
local token = decoded.github_copilot
...
local payload = vim.json.encode({ ["github.com"] = { oauth_token = token } })
...
```

処理フロー:

1. Avante が参照する hosts.json / apps.json の有無を確認
2. 片方でも存在すれば何もしない
3. 無い場合だけ CopilotChat の tokens.json を読む
4. github_copilot トークンを抽出
5. ~/.config/github-copilot に hosts.json と apps.json を生成
6. パーミッションを rw------- に設定

このコードの効果:

- 認証ファイル消失時に Avante 起動エラーを自動回復
- 手動修復手順を毎回踏まなくてよくなる

#### 1-5. CopilotChat 定義

```lua
{
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
	cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain", "CopilotChatFix" },
	opts = {
		debug = false,
		model = "auto",
		window = { layout = "vertical", width = 0.5 },
		system_prompt = [[ ...日本語ルール... ]],
	},
	keys = {
		{ "<leader>cc", "<cmd>CopilotChatToggle<CR>", mode = "n" },
	},
}
```

技術的な意図:

- model = auto で環境差分を吸収
- cmd で遅延読込しつつ、必要なコマンド経路を明示
- keys で起動導線を一本化

#### 1-6. Avante 定義

```lua
opts = {
	provider = "copilot",
	auto_apply_diff_after_generation = false,
	mappings = {
		ask = "<leader>av",
		edit = "<leader>aE",
		refresh = "<leader>ar",
		toggle = { default = "<leader>at" },
	},
}
```

意図:

- provider を copilot に固定して Copilot 認証資産を使い回す
- auto_apply_diff_after_generation = false で意図しない変更適用を防止
- mappings を明示して既存 leader 空間と衝突しにくくした

### 2. wsl/nvim/lua/plugins/lsp.lua

cmp 側は Tab マッピングの条件分岐が核心です。

```lua
["<Tab>"] = cmp.mapping(function(fallback)
	if copilot_suggestion.is_visible() then
		copilot_suggestion.accept()
	elseif cmp.visible() then
		cmp.confirm({ select = true })
	else
		fallback()
	end
end, { "i", "s" }),
```

分岐の意味:

1. Copilot ghost text が見えている時は Copilot を採用
2. そうでなく cmp メニュー表示中なら cmp を確定
3. どちらも無ければ通常 Tab（インデント等）

この設計で、ユーザー要望の「cmp は Tab のまま維持」と「Copilot 優先確定」を両立しました。

### 3. wsl/nvim/lua/options.lua

CopilotChat の表示位置問題に対して、最小変更で解決しました。

```lua
vim.opt.splitright = true
```

CopilotChat の vertical レイアウトは splitright に従って左右を決めるため、プラグイン固有設定を増やさずに全体整合を取れます。

## 書いたコードの設計原則

今回のコードは次の原則で統一しました。

1. 失敗しやすい外部依存は明示指定する
   - 例: Node 実行ファイル
2. 連携境界の差異は自動補正する
   - 例: Avante が要求する hosts.json / apps.json 自動復元
3. UI 操作はキー導線を固定して学習コストを下げる
   - 例: <leader>co / <leader>cc / <leader>av
4. 優先順位は条件分岐で明文化する
   - 例: Tab で Copilot -> cmp -> fallback

## 変更後に得られたこと

- 補完、チャット、エージェントの3系統を同時運用できるようになった
- よくある障害（モデル不一致、Node不足、認証ファイル欠損）に対して回復力が上がった
- ドキュメントと実装が一致し、次回メンテの認知負荷が下がった

## 実際に発生したエラーと原因・対策

ここがこの移行で一番重要なパートです。

### エラー1: is_auto_trigger が nil

症状:

```text
attempt to call field 'is_auto_trigger' (a nil value)
```

原因:

- copilot.suggestion に is_auto_trigger() は存在しない

対応:

- toggle_auto_trigger() のみ使用
- 表示用の状態管理は独自に持つ形へ変更

### エラー2: CopilotChat の Model not found

症状:

```text
Model not found: gpt-4.1
Model not found: gpt-4o
Model not found: auto
```

原因:

- 固定モデル名と、実際に取得できるモデルの不一致
- さらに認証状態が不安定な時はモデル一覧自体が空になり得る

対応:

- model = auto を採用
- 認証ファイル周りを修正（後述）

### エラー3: Failed to authenticate with copilot / slow_down

症状:

```text
Auth error: slow_down
```

原因:

- device flow を短時間に繰り返してポーリング制限へ到達

対応:

- 認証リトライの間隔を空ける
- トークン永続化状態を先に確認してから再試行

### エラー4: Avante が copilot setup 未完了扱いになる

症状:

```text
You must setup copilot with either copilot.lua or copilot.vim
```

原因:

- Avante は ~/.config/github-copilot/hosts.json または apps.json を直接参照
- その時点で versions.json しか存在していなかった

ポイント:

- CopilotChat 側の tokens.json が存在していても、Avante は別の場所を見る

対応:

- tokens.json から hosts.json / apps.json を再生成
- さらに再発防止として、copilot.lua の config 内に自動復元ロジックを追加

### エラー5: Client copilot quit with exit code 24

症状:

```text
Node.js 22.13 is required to run GitHub Copilot but found 22.12.0
```

原因:

- 実行中の node が要件未満

対応:

- copilot_node_command を明示
- /home/siiiron/.nvm/versions/node/v24.13.0/bin/node を利用

## 現在の設定の肝

### 1) Copilot 本体

- lazy = false で初期化順を安定化
- Node 実行ファイルを明示
- suggestion のみ有効（panel 無効）

### 2) 補完連携

- cmp の Tab を維持しつつ、Copilot ghost text が見えている時だけ Copilot を先に確定

### 3) CopilotChat

- model = auto
- 日本語 system_prompt
- <leader>cc でトグル

### 4) Avante

- provider = copilot
- キーを ask/edit/refresh/toggle で明確に分離

## 更新したファイル

- wsl/nvim/lua/plugins/copilot.lua
- wsl/nvim/lua/plugins/lsp.lua
- wsl/nvim/lua/options.lua
- manual/copilotONnvim.md
- manual/how2plugins.md
- manual/keybinds.md

## 検証で使った代表コマンド

```bash
nvim --headless "+lua local ok,p=pcall(require,'avante.providers.copilot'); if ok then print('avante-copilot-load-ok', p.is_env_set()) else print('avante-copilot-load-fail') end" +qa
```

結果:

```text
avante-copilot-load-ok true
```

## 運用メモ（次回の自分向け）

1. Node のバージョン問題は最初に潰す
2. Model not found は model 固定値より認証状態を疑う
3. Avante エラー時は ~/.config/github-copilot/hosts.json をまず確認
4. device flow は連打せず、少し待ってから再実行

## 5分チェックリスト

1. node -v が 22.13 以上か
2. copilot_node_command の実体パスが有効か
3. ~/.config/github-copilot/hosts.json または apps.json があるか
4. ~/.local/share/nvim/copilot_chat/tokens.json があるか
5. <leader>co / <leader>cc / <leader>av が動くか

## まとめ

今回の移行で大事だったのは、プラグインの導入よりも「認証ファイル参照先の違い」と「Node 実行バージョン」を最初に揃えることでした。  
補完、チャット、エージェントを同時運用する場合は、単一プラグインの設定だけでは完結せず、連携先の前提条件を揃える作業が必要です。

同じ症状が再発したときは、まずこのレポートの「エラー4」「エラー5」から確認すると復旧が早いです。
