--NOTE: CUSTOM PLUGINS CONFIG-----------------------------------------------
-- Configuración de plegado
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Configuración de capacidades LSP para plegado
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Configuración de servidores LSP
local language_servers = require("lspconfig").util.available_servers()
for _, ls in ipairs(language_servers) do
  require('lspconfig')[ls].setup({
    capabilities = capabilities
  })
end

-- Configuración del plugin UFO
require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})


--NOTE: config for nvim-highlight-colors -----------------------------------
vim.opt.termguicolors = true
require('nvim-highlight-colors').setup({})
-- options
require("nvim-highlight-colors").setup {
  ---Render style
  ---@usage 'background'|'foreground'|'virtual'
  render = 'virtual',

  ---Set virtual symbol (requires render to be set to 'virtual')
  virtual_symbol = '',

  ---Set virtual symbol suffix (defaults to '')
  virtual_symbol_prefix = ' ',

  ---Set virtual symbol suffix (defaults to ' ')
  virtual_symbol_suffix = '',

  ---Set virtual symbol position()
  ---@usage 'inline'|'eol'|'eow'
  ---inline mimics VS Code style
  ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
  ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
  virtual_symbol_position = 'inline',

  ---Highlight hex colors, e.g. '#FFFFFF'
  enable_hex = true,

  ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
  enable_rgb = true,

  ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
  enable_hsl = true,

  ---Highlight CSS variables, e.g. 'var(--testing-color)'
  enable_var_usage = true,

  ---Highlight named colors, e.g. 'green'
  enable_named_colors = true,

  ---Highlight tailwind colors, e.g. 'bg-blue-500'
  enable_tailwind = false,

  ---Set custom colors
  ---Label must be properly escaped with '%' to adhere to `string.gmatch`
  --- :help string.gmatch
  custom_colors = {
    { label = '%-%-theme%-primary%-color',   color = '#0f1219' },
    { label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
  }
}
