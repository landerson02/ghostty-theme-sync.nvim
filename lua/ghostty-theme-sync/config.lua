local M = {}

--- User's configuration
--- @class GhosttySyncConfig
--- @field ghostty_config_path string: Path to your ghostty config file
--- @field persist_nvim_theme boolean: Persist the theme in the nvim config file
--- @field nvim_config_path string: Path to the nvim config file to persist the theme

--- Default configuration
--- @type GhosttySyncConfig
-- M.config = {
local defaults = {
	-- Path to your ghostty config file
	ghostty_config_path = "~/.config/ghostty/config",
	persist_nvim_theme = false,
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

	if M.options.persist_nvim_theme and (M.options.nvim_config_path == nil or M.options.nvim_config_path == "") then
		error("You must define a nvim config path to keep the nvim theme")
	end
end

return M
