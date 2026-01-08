# Neovim Keybindings

このドキュメントは、Neovimのキーマップ設定をまとめたものです。リーダーキーはスペースキーです。

## リーダーキー
- **Leader**: `Space`

## 入力モード (Insert Mode)
| キー | 説明 |
|------|------|
| `jj` / `jk` | ノーマルモードに戻る (Esc) |

## ノーマルモード (Normal Mode)
| キー | 説明 |
|------|------|
| `Enter` | 検索ハイライトを消す |
| `J` | 下に5行移動 |
| `K` | 上に5行移動 |
| `H` | 行頭へ移動 |
| `L` | 行末へ移動 |
| `+` | カーソル下の数値を増やす |
| `-` | カーソル下の数値を減らす |
| `<leader>w` | 保存 (:w) |
| `<leader>q` | 終了 (:q) |
| `<leader>m` | ファイルから ^M (CR) を削除 |
| `<F5>` | 現在のファイルをビルド / 実行（C/C++/Python を自動判定） |

## ビジュアルモード (Visual Mode)
| キー | 説明 |
|------|------|
| `H` | 行頭へ移動 |
| `L` | 行末へ移動 |

## Telescope (検索関連)
| キー | 説明 |
|------|------|
| `<leader>ff` | ファイル検索 (find_files) |
| `<leader>fg` | ライブgrep検索 (live_grep) |
| `<leader>fb` | バッファ検索 (buffers) |

## Git関連
| キー | 説明 |
|------|------|
| `<leader>gs` | Gitステータス表示 (:Git) |

## バッファ関連
| キー | 説明 |
|------|------|
| `<leader>bn` | 次のバッファ (bnext) |
| `<leader>bp` | 前のバッファ (bprevious) |
| `<leader>bd` | バッファ削除 (bdelete) |

## ウィンドウ関連
| キー | 説明 |
|------|------|
| `<leader>ws` | 水平分割 (split) |
| `<leader>wv` | 垂直分割 (vsplit) |
| `<leader>wc` | ウィンドウ閉じる (close) |

## NvimTree (ファイルツリー)
| キー | 説明 |
|------|------|
| `<leader>e` | NvimTreeトグル (NvimTreeToggle) |

## ターミナル関連 (Terminal Mode)
| キー | 説明 |
|------|------|
| `<Esc>` (terminal) | ターミナルモードを抜けてノーマルモードへ (<C-\><C-n>) |
| `Ctrl+h/j/k/l` (terminal) | ノーマルモードに戻してウィンドウ移動（<C-\><C-n><C-w>h 等） |

## WezTerm（端末）ショートカット
WezTerm 設定 (examples/windows/keybinds.lua) に基づく主要ショートカット一覧。

| キー | 説明 |
|------|------|
| `LEADER + w` | ワークスペース選択ランチャー表示 |
| `LEADER + $` | ワークスペース名変更 |
| `LEADER + W` | 新しいワークスペース作成（プロンプト） |
| `SUPER + p` | コマンドパレット表示 |
| `CTRL + Tab` / `SHIFT|CTRL + Tab` | タブ移動 |
| `LEADER + {` / `LEADER + }` | タブを左右に移動 |
| `SUPER + t` | 新しいタブ作成 |
| `SUPER + w` | タブを閉じる（確認） |
| `ALT + Enter` | フルスクリーン切替 |
| `LEADER + [` | Copy / Enter copy mode |
| `SUPER + c` | クリップボードへコピー |
| `SUPER + v` | クリップボードから貼り付け |
| `LEADER + d` / `LEADER + r` | 縦/横でペイン分割 |
| `LEADER + x` | ペインを閉じる（確認） |
| `LEADER + h/l/k/j` | ペイン移動（Left/Right/Up/Down） |
| `CTRL|SHIFT + [` | ペイン選択モード |
| `LEADER + z` | 選択ペインのズーム切替 |
| `CTRL + +` / `CTRL + -` / `CTRL + 0` | フォントサイズ増減/リセット |
| `SUPER + 1..9` | 指定タブへ移動 |
| `SHIFT|CTRL + r` | 設定の再読み込み |
| `LEADER + s` | ペインリサイズ用キー テーブルへ移行 |
| `LEADER + a` | 短時間のペイン選択テーブルをアクティブにする |

（詳細な key table / copy_mode のキーは WezTerm の設定ファイルを参照してください）
