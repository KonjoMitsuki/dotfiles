-- plugins.lua: Neovimプラグイン設定ファイル（lazy.nvim使用）
-- 分割構成により lua/plugins/ ディレクトリから自動読み込み

local plugin_specs = {}

-- lua/plugins/ 配下のすべてのLuaファイルを読み込み
for _, plugin_file in ipairs(vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/plugins", "*.lua", false, true)) do
  local module_name = vim.fn.fnamemodify(plugin_file, ":t:r")
  if module_name ~= "init" then
    local ok, plugins = pcall(require, "plugins." .. module_name)
    if ok and type(plugins) == "table" then
      for _, plugin_spec in ipairs(plugins) do
        table.insert(plugin_specs, plugin_spec)
      end
    end
  end
end

return plugin_specs

