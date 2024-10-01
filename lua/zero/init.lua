local M = {}

M.setup = function(user_config)
	-- for colorscheme
	require("zero.colors").setup(user_config)

	-- for config
	require("zero.config").setup(user_config)
end

return M
