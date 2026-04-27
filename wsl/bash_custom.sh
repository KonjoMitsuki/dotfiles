# =============================================================================
# ~/.dotfiles/bash_custom.sh
# カスタム設定 (エイリアス / 関数 / 環境変数)
# ~/.bashrc から source ~/dotfiles/bash_custom.sh で読み込む
# =============================================================================

# -----------------------------------------------------------------------------
# Exports / 環境変数
# -----------------------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$PATH:$HOME/.local/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]             && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ]    && \. "$NVM_DIR/bash_completion"

# シークレットはファイルから読み込む（平文でここに書かない！）
# トークンを更新したら: echo 'NEW_TOKEN' > ~/.config/secrets/discord_bot_token
[ -f "$HOME/.config/secrets/discord_bot_token" ] \
    && export DISCORD_BOT_TOKEN="$(cat "$HOME/.config/secrets/discord_bot_token")"

# -----------------------------------------------------------------------------
# Neovim / エディタ
# -----------------------------------------------------------------------------
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# -----------------------------------------------------------------------------
# 設定ファイルの即時編集・反映
# -----------------------------------------------------------------------------
alias ev='nvim ~/.config/nvim/init.lua'   # Neovim 設定
alias eb='nvim ~/dotfiles/bash_custom.sh' # このファイル自体を編集
alias sv='source ~/.bashrc'               # 設定を即時反映

# -----------------------------------------------------------------------------
# WSL / Windows
# -----------------------------------------------------------------------------
# Windows ユーザーフォルダへ移動して PowerShell 起動
alias winps='cd /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d "\r") && powershell.exe'

# -----------------------------------------------------------------------------
# Git
# -----------------------------------------------------------------------------
alias g='git'
alias gs='git status -sb'               # ブランチ情報付き短縮表示
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'                # 差分確認しながらコミット
alias gcm='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gsw='git switch'
alias lg='lazygit'

# -----------------------------------------------------------------------------
# Functions / 自作関数
# -----------------------------------------------------------------------------

# Yazi でディレクトリ移動（終了後にカレントディレクトリを引き継ぐ）
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
