-- Mapping a binding that starts with <leader> should use WhichKeys binding
-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

--------------------------------------------------------------------------------
-- Utility package
--------------------------------------------------------------------------------

-- TODO(nickbar01234): Refactor to a different folder
vim.opt.runtimepath:append(",/Users/nickbar01234/.config/lvim/lua-utils")

local Array = require "array"

--------------------------------------------------------------------------------
-- Color scheme
--------------------------------------------------------------------------------
lvim.colorscheme = "monokai_pro"

-------------------------------------------------------------------------------
-- GUI
-------------------------------------------------------------------------------
vim.wo.relativenumber = true
vim.wo.colorcolumn = "80,120"

-------------------------------------------------------------------------------
-- Editor Behavior
-------------------------------------------------------------------------------

vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmode = true

-------------------------------------------------------------------------------
-- Movement
-------------------------------------------------------------------------------

-- Cycle between tab
lvim.builtin.which_key.mappings["bn"] = {
  "<cmd>BufferLineCycleNext<CR>", "Next tab"
}
lvim.builtin.which_key.mappings["bb"] = {
  "<cmd>BufferLineCyclePrev<CR>", "Previous tab"
}

-- Move between panes
lvim.builtin.which_key.mappings["h"] = {
  "<C-w>h", "Left pane"
}
lvim.builtin.which_key.mappings["j"] = {
  "<C-w>j", "Down pane"
}
lvim.builtin.which_key.mappings["k"] = {
  "<C-w>k", "Up pane"
}
lvim.builtin.which_key.mappings["l"] = {
  "<C-w>l", "Right pane"
}

-------------------------------------------------------------------------------
-- Misc
-------------------------------------------------------------------------------

-- Remove highlight
lvim.builtin.which_key.mappings["zh"] = {
  "<cmd>noh<CR>", "No highlight"
}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
vim.api.nvim_create_user_command('Header',
  function ()
    local escape = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)

    vim.api.nvim_feedkeys(string.format("%s:set paste%s", escape, enter), 'n', false)

    local ft = vim.fn.expand("%:e")

    if ft == "lua" then
      vim.api.nvim_feedkeys(string.format("80i-%s", escape), 'n', false)
      vim.api.nvim_feedkeys("yyp", 'n', false)
      vim.api.nvim_feedkeys("^O--", 'n', false)
    -- else if Array.contains({ "c", "cpp" }, ft) then
    end

    vim.api.nvim_feedkeys(string.format("%s:set nopaste%s", escape, enter), 'n', false)
  end,
  {
    desc = "Create a pretty comment header. This command assumes that lvim is configured with comment togglers",
    nargs = 0
  }
)

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

lvim.plugins = {
  -- Color theme
  "marko-cerovac/material.nvim",
  "tanvirtin/monokai.nvim",
}
