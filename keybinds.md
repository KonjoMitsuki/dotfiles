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
