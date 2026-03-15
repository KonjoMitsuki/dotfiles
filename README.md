# dotfiles

WSL の Neovim/Starship と Windows の WezTerm を同じリポジトリで管理するための設定です。

## 対象構成

- WSL: Neovim + Starship
- Windows: WezTerm

## 動作確認済み環境 (2026-03-15)

- Neovim: `NVIM v0.12.0-dev-2013+g2d3dc070ce` (nightly/dev)
- WezTerm: `wezterm 20240203-110809-5046fc22`
- Starship: `starship 1.24.2`

上記以上のバージョンを入れたい場合は、このREADME内のインストール手順で nightly もしくは最新安定版を使ってください。

## 1. 事前準備

### 1-1. GitHub SSH 設定

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh -T git@github.com
```

公開鍵 (`~/.ssh/id_ed25519.pub`) を GitHub の SSH keys に登録してください。

### 1-2. dotfiles をクローン

```bash
cd ~
git clone git@github.com:KonjoMitsuki/dotfiles.git
```

## 2. WSL セットアップ

### 2-1. 必要ツールのインストール

```bash
sudo apt update
sudo apt install -y git curl software-properties-common
```

Neovim は nightly/dev 系 (0.12.0-dev 以上) を前提にする場合、以下を実行:

```bash
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim
```

### 2-2. Starship のインストール

```bash
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init bash)"' >> ~/.bashrc
source ~/.bashrc
```

インストール後の確認:

```bash
starship --version
```

### 2-3. 設定ファイルをリンク

```bash
mkdir -p ~/.config

# Neovim
ln -sfn ~/dotfiles/wsl/nvim ~/.config/nvim

# Starship
ln -sfn ~/dotfiles/common/starship.toml ~/.config/starship.toml
```

### 2-4. lazy.nvim を導入

```bash
mkdir -p ~/.local/share/nvim/lazy
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
```

### 2-5. 初回起動確認

```bash
nvim
```

Neovim 起動後に以下を実行すると、プラグイン状態を確認できます。

```vim
:Lazy sync
:checkhealth
```

バージョン確認:

```bash
nvim --version
```

## 3. Windows セットアップ

### 3-1. WezTerm をインストール

PowerShell で `scoop` を使って nightly を入れる場合 (推奨):

```powershell
scoop bucket add versions
scoop install versions/wezterm-nightly
```

更新時:

```powershell
scoop update
scoop update wezterm-nightly
```

stable を使う場合は公式サイトまたは任意のパッケージマネージャーでも構いません。

### 3-2. 設定ファイルをリンク

管理者権限の PowerShell で実行:

```powershell
New-Item -ItemType SymbolicLink -Path "$HOME\.wezterm.lua" -Target "$HOME\dotfiles\windows\wezterm.lua"
```

### 3-3. フォントを導入

JetBrainsMono Nerd Font をインストールしてください。
フォント未導入だと WezTerm/Neovim のアイコン表示が崩れます。

バージョン確認:

```powershell
wezterm --version
```

## 4. 動作確認

- WSL で `nvim` が起動する
- Starship プロンプトが表示される
- Windows で WezTerm 起動時に設定が反映される
- `nvim --version` が `v0.12.0-dev` 以上
- `wezterm --version` が `20240203-110809-5046fc22` 以上
- `starship --version` が `1.24.2` 以上

## 5. 関連ドキュメント

- キーバインド一覧: [manual/keybinds.md](./manual/keybinds.md)
- Neovim 設定ガイド: [manual/manual.md](./manual/manual.md)
- プラグインガイド: [manual/how2plugins.md](./manual/how2plugins.md)
- Copilot (任意): [manual/copilotONnvim.md](./manual/copilotONnvim.md)
