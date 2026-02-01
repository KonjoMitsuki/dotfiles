# AtCoder cliの導入
# 環境
- Ubuntu 22.04 LTS
- wsl2
- windows11

# 参考文献
https://zenn.dev/ok_xmonad/articles/ae1c5bf0a955c1

# 手順
## oj(Online Judge tools)のインストール
### pipxのインストール
pipxでojをインストールするためまずは、pipxを入れる
```bash
sudo apt install pipx
```

### ojのインストール
pipxがインストール出来たら、そのpipxを使って、ojをインストールします。

```bash
pipx install online-judge-tools --include-deps
pipx inject online-judge-tools setuptools
pipx inject online-judge-tools selenium
oj --version
```

### pipxでのメンテナンス
#### パッケージの更新
```bash
pipx upgrade online-judge-tools
```
#### パッケージのアンインストール
```bash
pipx uninstall online-judge-tools
```

## AtCoder CLIのインストール
### nodejsのインストール
AtCoder CLIはnodejsの環境が必要なので、まずはnodejsをインストールします。

```bash
# NVMを使っている場合（推奨）
nvm install --lts

# NVMを使っていない場合
sudo apt install nodejs npm
```

### AtCoder CLIのインストール
npmを使ってAtCoder CLIをインストールします。
**NVMを使用している場合は、sudoを付けずにインストールしてください。**

```bash
# NVMを使っている場合（推奨）
npm install -g atcoder-cli

# NVMを使っていない場合
sudo npm install -g atcoder-cli
```

### ツールを使う準備
accコマンド及びojコマンドを使うためには、まず、各コマンドでatcoderにログインしておく必要があります。

```bash
# oj でログイン（Seleniumでブラウザが開きます）
oj login https://atcoder.jp/

# ログイン確認
oj login --check https://atcoder.jp/

# acc でログイン
acc login
```

### トラブルシューティング
#### Cloudflare でブロックされる場合
ブラウザの Cookie を手動でコピーします：

1. Chrome で https://atcoder.jp にログイン
2. F12 → Application → Cookies → `https://atcoder.jp`
3. `REVEL_SESSION` の値をコピー
4. 以下のコマンドで Cookie ファイルを作成：

```bash
cat > ~/.local/share/online-judge-tools/cookie.jar << 'EOF'
#LWP-Cookies-2.0
Set-Cookie3: REVEL_SESSION="ここにコピーした値"; path="/"; domain="atcoder.jp"; path_spec; secure; expires="2027-01-01 00:00:00Z"; HttpOnly=None; version=0
EOF
```

5. ログイン確認：
```bash
oj login --check https://atcoder.jp/
```