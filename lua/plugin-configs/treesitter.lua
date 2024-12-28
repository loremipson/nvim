local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'bash',
      'lua',
      'vim',
      'vimdoc',
      'prisma',
      'typescript',
      'json',
      'go',
      'gowork',
      'gomod',
      'gosum',
      'regex',
      'sql',
      'gotmpl',
      'comment',
      'astro',
      'vue',
      'yaml',
    },
    sync_install = false,
    highlight = {
      enable = true,
    },
  }
end

return M
