local M = {}

--- User's configuration
--- @class GhosttySyncConfig
--- @field ghostty_config_path string: Path to your ghostty config file

--- Default configuration
--- @type GhosttySyncConfig
M.config = {
	-- Path to your ghostty config file
	ghostty_config_path = "~/.config/ghostty/config",
}

--- Setup function for the plugin
--- @param opts GhosttySyncConfig
function M.setup(opts)
	M.config = vim.tbl_extend("force", M.config, opts or {})

	if M.config.ghostty_config_path == nil then
		error("You must define a ghostty config path (make sure the file exists)")
	end
end

return M
