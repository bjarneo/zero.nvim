local M = {}

function M.setup(colors, config)
	-- Determine common background color
	local common_bg = config.transparent and "NONE" or colors.bg

	-- Define the theme for lualine
	local lualine_theme = {
		normal = {
			a = {
				bg = config.transparent and "NONE" or colors.bool,
				fg = config.transparent and colors.added or colors.bg,
			},
			b = { bg = common_bg, fg = colors.bool },
			c = { bg = colors.line_nr, fg = colors.bracket },
		},
		insert = {
			b = { bg = colors.bg, fg = colors.type },
			x = { bg = colors.line_nr, fg = colors.bool },
		},
		visual = {
			b = { bg = common_bg, fg = colors.type },
			x = { bg = colors.line_nr, fg = colors.bracket },
		},
		replace = {
			b = { bg = colors.bg, fg = colors.type },
			x = { bg = colors.line_nr, fg = colors.bool },
		},
		command = {
			b = { bg = colors.bg, fg = colors.type },
			x = { bg = colors.line_nr, fg = colors.bool },
		},
		inactive = {
			b = { bg = colors.eob, fg = colors.string },
			c = { bg = colors.eob, fg = colors.string },
		},
	}

	-- Check if lualine is available before setting it up
	local ok, lualine = pcall(require, "lualine")
	if ok then
		lualine.setup({
			options = {
				theme = lualine_theme,
			},
		})
	end
end

return M
