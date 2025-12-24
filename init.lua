require('core.keymaps')
require('core.options')
require('core.lazy')
require('core.lsp')
require('core.diagnostics')
require('core.bigfile')

vim.opt.statusline = "%!v:lua.require('core.statusline').statusline()"
