local sync = require("ghostty-theme-sync.sync")

vim.api.nvim_create_user_command("GhosttyTheme", function()
	sync.pick_theme()
end, {})
