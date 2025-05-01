-- NOTE: java formater

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("jdtls")

formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "google-java-format",
    filetypes = { "java" },
  }
}

local dap = require('dap')

-- Ruta al directorio de Mason
local mason_path = vim.fn.stdpath('data')

-- Ruta al JDK instalado con SDKMAN
local java_home = '/home/lenn/.sdkman/candidates/java/current'

-- Configuración del adaptador DAP para Java
dap.adapters.java = {
  type = 'executable',
  command = 'java',
  args = {
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.level=ALL',
    '-Duser.language=en',
    '-Duser.region=US',
    '-cp', vim.fn.glob(mason_path .. "/mason/packages/jdtls/plugins/com.microsoft.java.debug.plugin-*.jar"),
  },
  javaHome = java_home,
}

-- Configuración de lanzamiento de Java
dap.configurations.java = {
  {
    type = 'java',
    request = 'launch',
    name = "Launch Java Program",
    mainClass = "${file}",
    cwd = '${workspaceFolder}',
  },

  -- Configuración de depuración de pruebas Java (opcional)
  {
    type = 'java',
    request = 'launch',
    name = "Launch Java Test",
    mainClass = "org.junit.jupiter.api.Test",
    cwd = '${workspaceFolder}',
  },
}
