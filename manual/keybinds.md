# Keybinds Manual

このファイルは、現在の設定に基づくキーバインド一覧です。

- セットアップ手順: [../README.md](../README.md)

- Neovim 実体: [wsl/nvim/lua/keymaps.lua](wsl/nvim/lua/keymaps.lua)
- WezTerm 実体: [windows/keybinds.lua](windows/keybinds.lua)

## 共通ルール

- Neovim の Leader キーは Space。

## Neovim

### Insert mode

| キー            | 動作                                                   |
| --------------- | ------------------------------------------------------ |
| jj / jk         | Normal に戻る (Esc)                                    |
| Ctrl+l          | 右へ1文字移動                                          |
| Ctrl+\\ Ctrl+\\ | Noice 通知を閉じる（Noice が無い場合は notify を試行） |

### Normal mode: 基本編集

| キー     | 動作                                                  |
| -------- | ----------------------------------------------------- |
| Enter    | 検索ハイライト解除                                    |
| J / K    | 5行下 / 5行上へ移動                                   |
| H / L    | 行頭 / 行末へ移動                                     |
| + / -    | 数値インクリメント / デクリメント                     |
| Leader+m | ファイル内の CR (^M) を削除                           |
| Leader+w | 保存                                                  |
| Leader+q | 終了                                                  |
| F5       | 現在ファイルを保存し、C/C++/Python をビルドまたは実行 |

### Normal mode: 検索・プラグイン

| キー      | 動作                         |
| --------- | ---------------------------- |
| Leader+ff | Telescope find_files         |
| Leader+fg | Telescope live_grep          |
| Leader+fb | Telescope buffers            |
| Leader+o  | Oil を開く                   |
| Leader+t  | ToggleTerm を開閉            |
| Leader+e  | NvimTree を開閉              |
| Leader+gs | Git コマンド画面を開く       |
| Leader+nd | 通知を閉じる（Noice/notify） |

### Normal mode: バッファ・ウィンドウ

| キー                              | 動作                        |
| --------------------------------- | --------------------------- |
| Leader+bn / Leader+bp             | 次 / 前のバッファ           |
| Leader+bd                         | バッファ削除                |
| Leader+ws / Leader+wv             | 水平 / 垂直分割             |
| Leader+wc                         | ウィンドウを閉じる          |
| Ctrl+h / Ctrl+j / Ctrl+k / Ctrl+l | ウィンドウ移動              |
| Alt+Left / Alt+Right              | ウィンドウ幅を縮小 / 拡大   |
| Alt+Up / Alt+Down                 | ウィンドウ高さを拡大 / 縮小 |

### Visual mode

| キー  | 動作              |
| ----- | ----------------- |
| H / L | 行頭 / 行末へ移動 |

### Terminal mode

| キー | 動作                     |
| ---- | ------------------------ |
| Esc  | Terminal mode から抜ける |

### LSP

| キー      | 動作        |
| --------- | ----------- |
| Leader+ca | Code Action |
| Leader+k  | Hover       |

### Clipboard（上書き動作）

以下はシステムクリップボード優先に上書きされています。

| キー   | 動作                       |
| ------ | -------------------------- |
| y / yy | クリップボードへコピー     |
| d      | クリップボードへ削除       |
| c      | クリップボードへ変更       |
| p / P  | クリップボードから貼り付け |

## WezTerm

### コピペ

| キー          | 動作                                   |
| ------------- | -------------------------------------- |
| Ctrl+c        | 選択時はコピー、未選択時は SIGINT 送信 |
| Ctrl+v        | 貼り付け                               |
| Alt+c / Alt+v | コピー / 貼り付け                      |

### ワークスペース・タブ

| キー                      | 動作                   |
| ------------------------- | ---------------------- |
| Leader+w                  | ワークスペース選択     |
| Leader+$                  | ワークスペース名変更   |
| Leader+W                  | 新規ワークスペース作成 |
| Ctrl+Tab / Shift+Ctrl+Tab | タブ移動               |
| Leader+{ / Leader+}       | タブを左 / 右へ移動    |
| Alt+t                     | 新規タブ               |
| Alt+w                     | タブを閉じる           |
| Alt+1..9                  | 指定タブへ移動         |

### ペイン操作

| キー                                      | 動作                                   |
| ----------------------------------------- | -------------------------------------- |
| Leader+d / Leader+r                       | 縦 / 横分割                            |
| Leader+x                                  | ペインを閉じる                         |
| Leader+h / Leader+j / Leader+k / Leader+l | ペイン移動                             |
| Ctrl+Shift+[                              | PaneSelect                             |
| Leader+z                                  | ペインズーム切替                       |
| Leader+s                                  | resize_pane キーテーブルへ             |
| Leader+a                                  | activate_pane キーテーブルへ（短時間） |

### UI・その他

| キー                                 | 動作                               |
| ------------------------------------ | ---------------------------------- |
| Alt+Enter                            | フルスクリーン切替                 |
| Alt+p / Ctrl+Shift+p                 | コマンドパレット                   |
| Ctrl+Shift+r                         | 設定再読み込み                     |
| Ctrl++ / Ctrl+- / Ctrl+0             | フォント拡大 / 縮小 / リセット     |
| Ctrl+Alt+c / Ctrl+Alt+z / Ctrl+Alt+x | 透過度を上げる / 下げる / リセット |

### Copy mode

Leader+[ で Copy mode に入ります。hjkl 移動、v/V/Ctrl+v 選択、y または Enter でコピー、Esc で終了できます。
