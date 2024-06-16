require('telescope').setup{
  defaults = {
    path_display={"smart"}
  }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})

local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<c-s>"] = actions.select_vertical,
        ["<c-x>"] = actions.select_horizontal,
        },
      n = {
        ["<c-s>"] = actions.select_vertical,
        ["<c-x>"] = actions.select_horizontal,
        },
      }
    }
  }

