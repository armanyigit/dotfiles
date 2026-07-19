-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.filetype.add({ extension = { isml = "html" } })

-- gf / gd navigation for SFCC ISML template includes
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.isml",
  callback = function(ev)
    -- Walk up from the buffer directory to find the SFCC project root
    -- (identified by a "cartridges/" sibling directory)
    local dir = vim.fn.fnamemodify(ev.file, ":p:h")
    local root = nil
    while true do
      if vim.fn.isdirectory(dir .. "/cartridges") == 1 then
        root = dir
        break
      end
      local parent = vim.fn.fnamemodify(dir, ":h")
      if parent == dir then break end
      dir = parent
    end

    if root then
      local dirs = vim.fn.glob(root .. "/cartridges/*/cartridge/templates/default", false, true)
      vim.opt_local.path = table.concat(dirs, ",")
    end

    vim.opt_local.suffixesadd:prepend(".isml")
    -- Strip leading "/" from paths like template="/common/layout/page"
    vim.opt_local.includeexpr = "substitute(v:fname,'^/','','')"
    -- Teach Neovim how to extract the path from template="..." attributes
    vim.opt_local.include = [[template="\zs[^"$]\+\ze"]]
  end,
})
