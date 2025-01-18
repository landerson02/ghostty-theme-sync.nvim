local M = {}

--- User's configuration
--- @class GhosttySyncConfig
--- @field ghostty_config_path string: Path to your ghostty config file

--- Default configuration
--- @type GhosttySyncConfig
-- M.config = {
local defaults = {
	-- Path to your ghostty config file
	ghostty_config_path = "~/.config/ghostty/config",
	nvim_config_path = "",
}

--- @type GhosttySyncConfig
M.options = {}

--- Setup function for the plugin
--- @param opts GhosttySyncConfig
function M.setup(opts)
	M.options = vim.tbl_extend("force", defaults, opts or {})

	if M.options.ghostty_config_path == nil then
		error("You must define a ghostty config path (make sure the file exists)")
	end
end

return M
