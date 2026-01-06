# dotfiles

## WSL
- nvim
- starship

## Windows
- wezterm

## Setup
WSL:
```bash
ln -s ~/dotfiles/wsl/nvim ~/.config/nvim
ln -s ~/dotfiles/common/starship.toml ~/.config/starship.toml
```
# 環境構築手順書 (dotfiles 導入ガイド)
このドキュメントは、GitHub 上の dotfiles リポジトリを使用して、Windows (WezTerm) および WSL (Neovim/Starship) の環境を構築する手順をまとめたものです。

1. GitHub への SSH 接続設定
GitHub から安全にリポジトリを操作するために SSH 鍵を設定します。

SSH キーの生成 ターミナル（WSL または PowerShell）で以下を実行します。

```Bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
GitHub への登録 表示された公開鍵（~/.ssh/id_ed25519.pub の中身）をコピーし、GitHub の [Settings > SSH and GPG keys] に登録します。

接続確認

```Bash
ssh -T git@github.com
※ 初回接続時に聞かれる確認には yes と入力します。
```
2. リポジトリのクローン
ホームディレクトリ直下に `dotfiles` をクローンします。

```Bash
cd ~
git clone git@github.com:KonjoMitsuki/dotfiles.git
```

3. シンボリックリンクの作成
実体ファイルを `dotfiles` フォルダに置いたまま、各アプリの設定パスへリンクを張ります。

> WSL (Neovim / Starship)
**WSL** のターミナルで実行します。

```Bash
# Neovim
mkdir -p ~/.config
ln -s ~/dotfiles/wsl/nvim ~/.config/nvim
# Starship
ln -s ~/dotfiles/common/starship.toml ~/.config/starship.toml
```
> Windows (WezTerm)
管理者権限の PowerShell で実行します。

```PowerShell
New-Item -ItemType SymbolicLink -Path "$HOME\.wezterm.lua" -Target "$HOME\dotfiles\windows\wezterm.lua"
```
4. フォントのインストール
プロンプトや UI のアイコンを正しく表示するために、JetBrainsMono Nerd Font を導入します。

Nerd Fonts 公式サイト から JetBrainsMono をダウンロード。

解凍した .ttf ファイルを右クリックし、「すべてのユーザーに対してインストール」を選択。

5. Neovim プラグインマネージャー (lazy.nvim) の導入
dotfiles にはプラグイン本体を含めていないため、手動で lazy.nvim をインストールします。

ディレクトリ作成とクローン

Bash
mkdir -p ~/.local/share/nvim/lazy
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
セットアップ nvim を起動すると、plugins.lua に記述されたプラグインが自動的にインストールされます。

補足事項
WezTerm Nightly について: 最新機能を使いたい場合は、公式サイトのインストーラーまたは scoop (versions バケット) を使用して導入します。

エラー対処: Key is already in use と出た場合は、既存の鍵が別のアカウントに登録されていないか確認するか、新しい鍵を生成して ~/.ssh/config で管理してください。
