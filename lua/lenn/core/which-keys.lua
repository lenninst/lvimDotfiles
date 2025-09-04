-- hop
lvim.builtin.which_key.mappings["k"] = {
  name = " 󱕘 Hop",
  w = { "<cmd>HopWord<CR>", "Word" },
  z = { "<cmd>HopChar1<CR>", "Char" },
  v = { "<cmd>HopVertical<CR>", "Vertical" },
  a = { "<cmd>HopAnywhere<CR>", "Anywhere" },
  s = { "<cmd>HopPattern<CR>", "Pattern" },
  l = { "<cmd>HopWordCurrentLine<CR>", "Word Current Line" },
  j = { "<cmd>HopAnywhereCurrentLine<CR>", "Anywhere Current Line" },
  i = { "<cmd>HopLineStart<CR>", "Line Start" },
}

-- latex
lvim.builtin.which_key.mappings["v"] = {
  name = "  VimTeX",
  v = { "<cmd>VimtexView<CR>", "Ver PDF" },
  s = { "<cmd>VimtexStop<CR>", "Detener compilación" },
  o = { "<cmd>VimtexOutline<CR>", "Ver índice" },
  c = { "<cmd>VimtexCompile<CR>", "Compilar" },
}

--ufo folding
lvim.builtin.which_key.mappings["z"] = {
  name = "  Plegado",
  R = { "<cmd>lua require('ufo').openAllFolds()<CR>", "Abrir todos los pliegues" },
  M = { "<cmd>lua require('ufo').closeAllFolds()<CR>", "Cerrar todos los pliegues" },
  a = { "<cmd>lua vim.cmd.normal('za')<CR>", "Plegar función/bloque actual" },
}

-- trouble . diagnostics
lvim.builtin.which_key.mappings["t"] = {
  name = "  Trouble",
  d = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)" },
  b = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)" },
  l = { "<cmd>Trouble loclist toggle<cr>", "Location List (Trouble)" },
  q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)" },
}

-- copilot
lvim.builtin.which_key.mappings["C"] = {
  name = "  Copilot",
  a = { "<cmd>Copilot enable<CR>", "Activar Copilot" },
  d = { "<cmd>Copilot disable<CR>", "Desactivar Copilot" },
  t = { "<cmd>Copilot toggle<CR>", "Alternar Copilot" },
  p = { "<cmd>Copilot panel<CR>", "Abrir Panel de Copilot" },
  s = { "<cmd>Copilot status<CR>", "Ver estado de Copilot" },
  w = { "<cmd>Copilot workspace add<CR>", "Añadir carpeta al Workspace" },
  x = { "<cmd>Copilot workspace remove<CR>", "Eliminar carpeta del Workspace" },
  r = { "<cmd>Copilot refresh<CR>", "Refrescar sugerencias" },
}

-- copilotchat
lvim.builtin.which_key.mappings["a"] = {
  name = "  Copilot Chat",
  o = { "<cmd>CopilotChatOpen<CR>", "Abrir chat" },
  q = { "<cmd>CopilotChatClose<CR>", "Cerrar chat" },
  t = { "<cmd>CopilotChatToggle<CR>", "Alternar chat" },
  s = { "<cmd>CopilotChatStop<CR>", "Detener salida" },
  r = { "<cmd>CopilotChatReset<CR>", "Reiniciar chat" },
  p = { "<cmd>CopilotChatPrompts<CR>", "Ver plantillas de prompts" },
  m = { "<cmd>CopilotChatModels<CR>", "Ver modelos disponibles" },
  a = { "<cmd>CopilotChatAgents<CR>", "Ver agentes disponibles" },
  e = { "<cmd>CopilotChatExplain<CR>", "Explicar código seleccionado" },
  v = { "<cmd>CopilotChatReview<CR>", "Revisar código seleccionado" },
  f = { "<cmd>CopilotChatFix<CR>", "Corregir código" },
  d = { "<cmd>CopilotChatDocs<CR>", "Agregar documentación" },
  x = { "<cmd>CopilotChatOptimize<CR>", "Optimizar código" },
  T = { "<cmd>CopilotChatTests<CR>", "Generar pruebas" },
  g = { "<cmd>CopilotChatCommit<CR>", "Generar mensaje de commit" },
  c = {
    function()
      local msg = vim.fn.input("CopilotChat: ")
      if msg ~= "" then
        vim.cmd("CopilotChat " .. msg)
      end
    end,
    "Enviar mensaje"
  },
}

--auto save
lvim.builtin.which_key.mappings["A"] = {
  name = "  Auto-save", -- Nombre del grupo
  t = { "<cmd>ASToggle<CR>", "Toggle Auto-Save" }, -- Comando para alternar
}

--todo comments template
lvim.builtin.which_key.mappings["o"] = {
  name = "  TODO comments",
  f = { ":lua InsertTodo('FIX')<CR>", " FIX: Solucionar errores o problemas" },
  i = { ":lua InsertTodo('TODO')<CR>", " TODO: Tareas pendientes o cosas por hacer" },
  h = { ":lua InsertTodo('HACK')<CR>", " HACK: Soluciones rápidas o temporales" },
  w = { ":lua InsertTodo('WARN')<CR>", " WARN: Advertencias o posibles problemas" },
  p = { ":lua InsertTodo('PERF')<CR>", "󰷴 PERF: Optimización de rendimiento" },
  u = { ":lua InsertTodo('NOTE')<CR>", " NOTE: Notas o información adicional" },
  t = { ":lua InsertTodo('TEST')<CR>", "󰙨 TEST: Para pruebas y verificaciones" },
}

-- Configuración de which_key para Neogen
lvim.builtin.which_key.mappings["d"] = {
  name = " 󰈙 NeogenDocs",
  g = { "<cmd>Neogen<CR>", "Generate Doc" },
  f = { "<cmd>Neogen func<CR>", "Function Doc" },
  c = { "<cmd>Neogen class<CR>", "Class Doc" },
  t = { "<cmd>Neogen type<CR>", "Type Doc" },
  i = { "<cmd>Neogen file<CR>", "File Doc" },
  m = { "<cmd>Neogen file --type=tsdoc<CR>", "TSDoc File" },
  j = { "<cmd>Neogen file --type=jsdoc<CR>", "JSDoc File" },
  p = { "<cmd>Neogen func --type=tsdoc<CR>", "TSDoc Function" },
  r = { "<cmd>Neogen func --type=jsdoc<CR>", "JSDoc Function" },
}
-- Auto Format group


-- Agregarlo a which_key con acceso desde <leader>F t
lvim.builtin.which_key.mappings["F"] = {
  name = "  Auto-Format",
  t = { "<cmd>ToggleFormatOnSave<CR>", "Alternar Format on Save" },
}


function InsertTodo(keyword)
  local line = vim.api.nvim_get_current_line()
  local filetype = vim.bo.filetype
  local new_line

  if filetype == "lua" then
    new_line = "-- " .. keyword .. ":  " .. line
  elseif filetype == "python" then
    new_line = "# " .. keyword .. ":  " .. line
  elseif filetype == "cpp" or filetype == "c" then
    new_line = "/* " .. keyword .. ":  */ " .. line
  elseif filetype == "javascript" then
    new_line = "/* " .. keyword .. ":  */ " .. line
  elseif filetype == "html" or filetype == "xml" then
    new_line = "<!-- " .. keyword .. ":  --> " .. line
  else
    new_line = "/* " .. keyword .. ":  */ " .. line
  end

  -- Cambia la línea actual con el comentario
  vim.api.nvim_set_current_line(new_line)

  -- Mueve el cursor dentro del bloque de comentario y entra en modo insert
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_win_set_cursor(0, { row, #new_line - 3 }) -- Posiciona antes de `*/`
  vim.cmd("startinsert")
end
