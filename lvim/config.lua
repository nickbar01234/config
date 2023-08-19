-- config.lua
-- Mapping a binding that starts with <leader> should use WhichKeys binding
-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


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
    -- TODO(hdoan): Good to handle error
    local commentstring = vim.api.nvim_buf_get_option(0, "commentstring")
    local symbol = string.match(commentstring, "([%p]+)%s")
    local comment = string.format("80i%s<Esc>", symbol)
    vim.cmd(symbol)
  end,
  {
    desc = "Create a pretty comment header",
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

  -- Markdown preview 
  -- { url = "git@github.com:iamcco/markdown-preview.nvim.git", ft = {"markdown", "Markdown"}}
}
