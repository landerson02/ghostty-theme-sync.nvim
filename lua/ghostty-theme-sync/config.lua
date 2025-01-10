local M = {}

M.config = {
	-- Path to your ghostty config file
	ghostty_config_path = "~/.config/ghostty/config",
}

function M.setup(user_config)
	M.config = vim.tbl_extend("force", M.config, user_config or {})

	if M.config.ghostty_config_path == nil then
		error("You must define a ghostty config path (make sure the file exists)")
	end
end

return M
