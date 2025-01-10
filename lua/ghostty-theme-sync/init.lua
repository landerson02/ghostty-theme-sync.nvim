local M = {}

M.commands = require("ghostty-theme-sync.commands")
M.config = require("ghostty-theme-sync.config")
M.sync = require("ghostty-theme-sync.sync")

function M.setup(user_config)
	M.config.setup(user_config)
end

return M
