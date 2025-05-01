print("hola desde mariadb")

local lspconfig = require('lspconfig')

lspconfig.sqls.setup({
  filetypes = { "sql", "mysql", "mariadb" },
  cmd = { "sqls" },
  settings = {
    sqls = {
    }
  }
})
