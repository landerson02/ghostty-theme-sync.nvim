local M = {}

M.config = require("ghostty-theme-sync.config")
M.setup = M.config.setup
M.commands = require("ghostty-theme-sync.commands")
M.sync = require("ghostty-theme-sync.sync")

return M
