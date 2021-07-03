local M = {}
M.search_dotfiles = function(opts)
  opts = opts or {}
  opts.cwd = '$HOME/.config/nvim/'
  opts.promt_title = 'VIM Files'
  require("telescope.builtin").find_files(opts)
end

M.grep_dotfiles = function(opts)
  opts = opts or {}
  opts.cwd = '$HOME/.config/nvim/'
  opts.promt_title = 'VIM Keywords'
  require("telescope.builtin").live_grep(opts)
end
return M
