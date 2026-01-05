-- wezterm.lua: WezTermターミナルエミュレータの設定ファイル

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 設定ファイルの自動リロードを有効化
config.automatically_reload_config = true

-- ウィンドウ閉じる時の確認を無効化
config.window_close_confirmation = "NeverPrompt"

-- フォント設定（JetBrainsMono Nerd Fontを使用）
config.font = wezterm.font("JetBrainsMono Nerd Font")

-- デフォルトのマウスバインディングを無効化しない
config.disable_default_mouse_bindings = false

-- WSL (Ubuntu) の設定（Windows環境の場合）
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    -- Ubuntu-20.04をホームディレクトリで起動
    config.default_prog = { 'wsl.exe', '-d', 'Ubuntu-20.04', '--cd', '~' }
elseif wezterm.target_triple == "x86_64-apple-darwin" then
    -- macOSの場合、zshをデフォルトシェルに
    config.default_prog = {'zsh'}
end

-- 設定の自動リロード（重複設定）
config.automatically_reload_config = true

-- フォントサイズ
config.font_size = 12.0

-- IMEを使用
config.use_ime = true

-- ウィンドウの背景不透明度
config.window_background_opacity = 1

-- macOSでの背景ブラー
config.macos_window_background_blur = 20

----------------------------------------------------
-- Tab（タブ関連設定）
----------------------------------------------------
-- タイトルバーを非表示（リサイズのみ）
config.window_decorations = "RESIZE"

-- タブバーを表示
config.show_tabs_in_tab_bar = true

-- タブが一つの時はタブバーを非表示
config.hide_tab_bar_if_only_one_tab = true

-- タブバーのフレーム設定（透過）
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- ウィンドウ背景を黒に設定
config.window_background_gradient = {
  colors = { "#000000" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false

-- タブ同士の境界線を非表示
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

-- タブの形をカスタマイズ（矢印付き）
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- タブの色設定
  local background = "#5c6d74"
  local foreground = "#FFFFFF"
  local edge_background = "none"
  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end
  local edge_foreground = background
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

-- ----------------------------------------------------
-- -- keybinds（キーバインド設定、コメントアウト）
-- ----------------------------------------------------
-- config.disable_default_key_bindings = true
-- config.keys = require("keybinds").keys
-- config.key_tables = require("keybinds").key_tables
-- config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

return config
