require("lspconfig").lemminx.setup({
	filetypes = { "xml" },
	settings = {
		xml = {
			fileAssociations = {
				{
					pattern = "**/*.axaml",
					systemId = "https://raw.githubusercontent.com/rogalmic/vscode-xml-complete/master/test/Avalonia/AvaloniaXamlSchema.Formatted.xsd",
				},
			},
		},
	},
})
