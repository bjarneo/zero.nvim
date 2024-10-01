local M = {}

-- Default configuration
M.config = {
	transparent = false,
	show_end_of_buffer = true,

	colors = {
		fg = "#c0c0c0", -- Light grey for main text
		bg = "#0a0a0a", -- Very dark grey, almost black for background
		cursor = "#c0c0c0", -- Light grey for cursor
		line_nr = "#404040", -- Dark grey for line numbers
		visual = "#1c1c1c", -- Slightly lighter than bg for visual selection
		comment = "#585858", -- Medium grey for comments
		string = "#c0c0c0", -- Light grey for strings
		func = "#c0c0c0", -- Light grey for functions
		kw = "#c0c0c0", -- Light grey for keywords
		identifier = "#c0c0c0", -- Light grey for identifiers
		type = "#c0c0c0", -- Light grey for types
		search_highlight = "#404040", -- Dark grey for search highlights
		operator = "#c0c0c0", -- Light grey for operators
		bracket = "#c0c0c0", -- Light grey for brackets
		preprocessor = "#585858", -- Medium grey for preprocessor
		bool = "#c0c0c0", -- Light grey for booleans
		constant = "#c0c0c0", -- Light grey for constants
		-- gitsigns colors
		added = "#585858", -- Medium grey for added
		changed = "#585858", -- Medium grey for changed
		removed = "#585858", -- Medium grey for removed
		-- Pmenu colors
		pmenu_bg = "#0a0a0a", -- Very dark grey for popup menu background
		pmenu_sel_bg = "#1c1c1c", -- Slightly lighter for selected item
		pmenu_fg = "#c0c0c0", -- Light grey for popup menu text
		-- endofbuffer color
		eob = "#0a0a0a", -- Very dark grey, same as bg
		-- telescope specific colors
		border = "#404040", -- Dark grey for borders
		title = "#c0c0c0", -- Light grey for titles
		-- bufferline specific colors
		bufferline_selection = "#1c1c1c", -- Slightly lighter than bg for selection
		-- lsp diagnostics colors
		error = "#585858", -- Medium grey for errors
		warning = "#585858", -- Medium grey for warnings
		hint = "#585858", -- Medium grey for hints
		info = "#585858", -- Medium grey for info
	},
}

-- Apply the colorscheme (using defined colors and groups)
function M.setup(user_config)
	-- Merge user configuration with default (optional)
	M.config = vim.tbl_deep_extend("force", M.config, user_config or {})

	-- Define colors and highlight groups (using updated config)
	local colors = M.config.colors

	local highlight_groups = {
		Normal = { fg = colors.fg, bg = M.config.transparent and "NONE" or colors.bg },
		Cursor = { fg = colors.cursor, bg = M.config.transparent and "NONE" or colors.bg },
		LineNr = { fg = colors.line_nr },
		Visual = { bg = colors.visual },

		Comment = { fg = colors.comment, gui = "italic" },
		String = { fg = colors.string },
		Function = { fg = colors.func },
		Keyword = { fg = colors.kw },
		Identifier = { fg = colors.identifier },
		Type = { fg = colors.type },
		PreProc = { fg = colors.preprocessor },
		Boolean = { fg = colors.bool },
		Constant = { fg = colors.constant },

		Search = { fg = colors.search_highlight, bg = "NONE", gui = "bold" },
		IncSearch = { fg = colors.search_highlight, bg = "NONE", gui = "bold" },
		Operator = { fg = colors.operator },
		Delimiter = { fg = colors.bracket },

		Pmenu = { fg = colors.pmenu_fg, bg = M.config.transparent and "NONE" or colors.pmenu_bg },
		PmenuSel = { fg = colors.pmenu_bg, bg = colors.pmenu_sel_bg, gui = "bold" },

		-- EndOfBuffer
		EndOfBuffer = {
			fg = M.config.show_end_of_buffer and colors.eob or colors.bg,
			bg = M.config.transparent and "NONE" or colors.bg,
		},

		-- LSP diagnostics
		DiagnosticError = { fg = colors.error },
		DiagnosticWarn = { fg = colors.warning },
		DiagnosticHint = { fg = colors.hint },
		DiagnosticInfo = { fg = colors.info },
		DiagnosticVirtualTextError = { fg = colors.error },
		DiagnosticVirtualTextWarn = { fg = colors.warning },
		DiagnosticVirtualTextHint = { fg = colors.hint },
		DiagnosticVirtualTextInfo = { fg = colors.info },

		DiagnosticUnderlineError = { gui = "underline", sp = colors.error },
		DiagnosticUnderlineWarn = { gui = "underline", sp = colors.warning },
		DiagnosticUnderlineHint = { gui = "underline", sp = colors.hint },
		DiagnosticUnderlineInfo = { gui = "underline", sp = colors.info },
	}

	-- Apply highlight groups
	for group_name, config in pairs(highlight_groups) do
		local cmd = "highlight " .. group_name
		if config.fg then
			cmd = cmd .. " guifg=" .. config.fg
		end
		if config.bg then
			cmd = cmd .. " guibg=" .. config.bg
		end
		if config.gui then
			cmd = cmd .. " gui=" .. config.gui
		end
		if config.sp then
			cmd = cmd .. " guisp=" .. config.sp
		end
		vim.cmd(cmd)
	end

	-- Apply plugin specific highlight groups
	require("zero.config").setup(M.config)
end

return M
