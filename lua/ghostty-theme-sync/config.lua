local M = {}

M.config = {
	theme_path = "~/.ghostty-nvim-theme.txt",
	ghostty_config_path = "~/.config/ghostty/config",
}

function M.setup(user_config)
	M.config = vim.tbl_extend("force", M.config, user_config or {})

	if M.config.theme_path == nil then
		error("You must define a theme file")
	end

	if M.config.ghostty_config_path == nil then
		error("You must define a ghostty config path (make sure the file exists)")
	end
end

return M
