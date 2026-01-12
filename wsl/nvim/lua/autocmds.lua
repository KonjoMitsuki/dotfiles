-- autocmds.lua: 自動化イベント（autocmd）の定義
-- InsertLeave で自動保存を行う設定

local M = {}

local exclude_filetypes = {
  gitcommit = true,
  gitrebase = true,
  hgcommit = true,
}

local group = vim.api.nvim_create_augroup("AutoSaveOnInsertLeave", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = group,
  pattern = "*",
  callback = function()
    -- バッファが編集済みで書き込み可能なときのみ保存
    if not (vim.bo.modified and vim.bo.modifiable) then
      return
    end

    -- filetype や buftype による除外
    if exclude_filetypes[vim.bo.filetype] then
      return
    end
    if vim.bo.buftype ~= "" then
      return
    end

    -- 安全に書き込み（エラーを無視）
    pcall(vim.cmd, "silent! write")
  end,
})

return M
