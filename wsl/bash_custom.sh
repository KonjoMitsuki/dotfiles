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
# winps 実行前の WSL 側ディレクトリを保存
WINPS_PREV_DIR=""

# Windows ユーザーフォルダへ移動して PowerShell 起動
function winps() {
    local win_home
    win_home="$(wslpath "$(cd /mnt/c && cmd.exe /d /c "echo %USERPROFILE%" 2>/dev/null | tr -d '\r' | tail -n 1)" 2>/dev/null)"
    if [[ -z "$win_home" || ! -d "$win_home" ]]; then
        echo "winps: Windows ユーザーフォルダの取得に失敗しました" >&2
        return 1
    fi
    WINPS_PREV_DIR="$PWD"
    builtin cd -- "$win_home" && powershell.exe -NoProfile
}

# winps 前の WSL ディレクトリへ戻る
function wslback() {
    if [[ -z "$WINPS_PREV_DIR" ]]; then
        echo "wslback: 戻り先が未保存です。先に winps を実行してください" >&2
        return 1
    fi
    if [[ ! -d "$WINPS_PREV_DIR" ]]; then
        echo "wslback: 保存された戻り先が存在しません: $WINPS_PREV_DIR" >&2
        return 1
    fi
    builtin cd -- "$WINPS_PREV_DIR"
}

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
