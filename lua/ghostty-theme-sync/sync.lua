local M = {}
local config = require("ghostty-theme-sync.config").config

-- Change nvim colorscheme
local function set_nvim_colorscheme(colorscheme)
	local success, err = pcall(function()
		vim.cmd("colorscheme " .. colorscheme)
	end)
	if not success then
		error("Failed to set nvim colorscheme: ", err)
	end
end

-- Change Ghostty config file with new theme
local function set_ghostty_colorscheme(colorscheme)
	local config_path = vim.fn.expand(config.ghostty_config_path)

	-- Read in config and update theme line
	local lines = {}
	for line in io.lines(config_path) do
		if line:match("^theme%s*=%s*") then
			table.insert(lines, "theme = " .. colorscheme)
		else
			table.insert(lines, line)
		end
	end

	-- Write the new config
	local file = io.open(config_path, "w")
	if not file then
		error("Failed to open ghostty config to write")
	end

	for _, line in ipairs(lines) do
		file:write(line .. "\n")
	end
	file:close()
end

local function get_nvim_colorschemes()
	local colorschemes = {}
	local output = vim.fn.getcompletion("", "color")

	for _, scheme in ipairs(output) do
		table.insert(colorschemes, scheme)
	end

	return colorschemes
end

local function get_ghostty_colorschemes()
	local colorschemes = {}
	local path = vim.fn.expand("./ghostty_themes.txt")

	for line in io.lines(path) do
		table.insert(colorschemes, line)
	end

	return colorschemes
end

function M.get_overlap()
	local nvim_colorschemes = get_nvim_colorschemes()
	local ghostty_colorschemes = get_ghostty_colorschemes()

	local set = {}
	local overlap = {}

	for _, value in ipairs(nvim_colorschemes) do
		set[value] = true
	end

	for _, value in ipairs(ghostty_colorschemes) do
		if set[value] then
			table.insert(overlap, value)
		end
	end

	return overlap
end

function M.set_colorscheme(colorscheme)
	set_nvim_colorscheme(colorscheme)
	set_ghostty_colorscheme(colorscheme)
end

function M.pick_theme()
	local themes = M.get_overlap()

	vim.ui.select(themes, { prompt = "Select a theme to sync:" }, function(selected)
		if selected then
			M.set_colorscheme(selected)
		end
	end)
end

return M