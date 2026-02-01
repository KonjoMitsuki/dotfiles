
# dotfiles から acc を使えるようになるまでの手順書

このマニュアルは、**GitHub 上の dotfiles リポジトリを clone した状態から**、
**WSL2 (Ubuntu) 上で `acc new` が問題なく使えるようになるまで**の手順をまとめたものです。

---

## 0. 前提条件

* Windows + WSL2 (Ubuntu)
* インターネット接続
* Git が使える状態

確認：

```bash
git --version
```

---

## 1. dotfiles を clone

```bash
cd ~
git clone <dotfilesのURL> dotfiles
```

構成例：

```
dotfiles/
├── atcoder/
│   ├── config.json
│   └── cpp/
│       ├── template.json
│       └── main.cpp
├── bash/
│   └── .bashrc
└── README.md
```

---

## 2. 必須パッケージのインストール

```bash
sudo apt update
sudo apt install -y \
  build-essential \
  curl \
  git \
  python3 \
  python3-pip
```

---

## 3. Node.js（nvm）をインストール

```bash
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install --lts
nvm use --lts
```

確認：

```bash
node -v
npm -v
```

---

## 4. atcoder-cli (acc) をインストール

```bash
npm install -g atcoder-cli
```

確認：

```bash
acc --version
```

---

## 5. online-judge-tools (oj) をインストール

```bash
pip3 install --user online-judge-tools
```

PATH を通す（bash 使用時）：

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

確認：

```bash
oj --version
```

---

## 6. acc 設定を dotfiles から有効化

### 既存設定がある場合は退避

```bash
mv ~/.config/atcoder-cli-nodejs ~/.config/atcoder-cli-nodejs.bak 2>/dev/null || true
```

### シンボリックリンク作成

```bash
mkdir -p ~/.config
ln -s ~/dotfiles/atcoder ~/.config/atcoder-cli-nodejs
```

確認：

```bash
ls ~/.config/atcoder-cli-nodejs
```

---

## 7. bash 設定を反映（任意だが推奨）

```bash
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
source ~/.bashrc
```

※ 既存 `.bashrc` がある場合は中身をマージする

---

## 8. AtCoder にログイン（初回のみ）

```bash
oj login https://atcoder.jp/
```

ブラウザでログイン → Cookie が保存される

---

## 9. 動作確認

```bash
mkdir -p ~/atcoder
cd ~/atcoder
acc new abc001
cd abc001/a
ls
```

正常なら：

```
main.cpp
tests/
```

---

## 10. よくあるエラーと対処

### `acc new` で main.cpp が出ない

* `~/.config/atcoder-cli-nodejs/cpp/template.json` が存在するか確認
* `program` が文字列配列になっているか確認

### `oj` が見つからない

* `which oj` でパス確認
* `config.json` の `oj-path` を修正

---

## 11. 完了チェックリスト

* [x] `acc --version` が通る
* [x] `oj --version` が通る
* [x] `acc new abcXXX` で `main.cpp` が生成される
* [x] `oj test` が実行できる
* [x] `acc submit` が可能

---

🎉 **これで dotfiles から競プロ環境を完全復元できます！**

PC 変更・WSL 再構築時も、この手順をなぞるだけで即復活します。
