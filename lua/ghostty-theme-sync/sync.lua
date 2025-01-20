local M = {}
local config = require("ghostty-theme-sync.config")
local translations = require("ghostty-theme-sync.translations")

--- Change nvim colorscheme
--- @param colorscheme string: The colorscheme to set in Neovim
local function set_nvim_colorscheme(colorscheme)
	local success, err = pcall(function()
		vim.cmd("colorscheme " .. colorscheme)
	end)
	if not success then
		error("Failed to set nvim colorscheme: ", err)
	end
end

--- Change nvim colorscheme permanently
--- @param colorscheme string: The colorscheme to set in Neovim
local function persist_nvim_colorscheme(colorscheme)
	if not config.options.persist_nvim_theme or not config.options.nvim_config_path then
		error("Please set the nvim config path")
	end

	local path = vim.fn.expand(config.options.nvim_config_path)

	-- Read in config and update colorscheme line
	local lines = {}
	for line in io.lines(path) do
		if line:match("^%s*vim.cmd.colorscheme") then
			table.insert(lines, "vim.cmd.colorscheme('" .. colorscheme .. "')")
		else
			table.insert(lines, line)
		end
	end

	-- Write the new config
	local file = io.open(path, "w")
	if not file then
		error("Failed to open nvim config to write")
	end

	for _, line in ipairs(lines) do
		file:write(line .. "\n")
	end
	file:close()
end

--- Change Ghostty config file with new theme
--- @param colorscheme string: The colorscheme to set in the ghostty config
local function set_ghostty_colorscheme(colorscheme)
	local config_path = vim.fn.expand(config.options.ghostty_config_path)

	-- Change colorscheme to ghostty format
	colorscheme = translations.nvim_to_ghostty[colorscheme] or colorscheme

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

--- Gets the available colorschemes in Neovim
--- @return table List of colorschemes
local function get_nvim_colorschemes()
	local colorschemes = {}
	local output = vim.fn.getcompletion("", "color")

	for _, scheme in ipairs(output) do
		table.insert(colorschemes, scheme)
	end

	return colorschemes
end

--- Gets the available colorschemes in Neovim
---@return table List of colorschemes
local function get_ghostty_colorschemes()
	local colorschemes = {}
	local path = debug.getinfo(1, "S").source:match("@(.*)/") .. "/../../ghostty_themes.txt"

	for line in io.lines(path) do
		table.insert(colorschemes, line)
	end

	return colorschemes
end

--- Get the colorschemes that exist in both Neovim and Ghostty
--- @return table List of colorschemes that are available in both Neovim and Ghostty
function M.get_overlap()
	local nvim_colorschemes = get_nvim_colorschemes()
	local ghostty_colorschemes = get_ghostty_colorschemes()

	local map = {}
	local overlap = {}

	for _, value in ipairs(nvim_colorschemes) do
		-- Map nvim to ghostty in the table
		local translated = translations.nvim_to_ghostty[value] or value
		map[translated] = value
	end

	for _, value in ipairs(ghostty_colorschemes) do
		if map[value] then
			table.insert(overlap, map[value])
		end
	end

	return overlap
end

--- Set the colorscheme in Neovim and Ghostty
--- @param colorscheme string: The colorscheme to set in Neovim and Ghostty
function M.set_colorscheme(colorscheme)
	set_nvim_colorscheme(colorscheme)
	if config.options.persist_nvim_theme then
		persist_nvim_colorscheme(colorscheme)
	end
	set_ghostty_colorscheme(colorscheme)
end

--- Opens a select menu to pick a theme to sync out of the valid options
function M.pick_theme()
	local themes = M.get_overlap()

	vim.ui.select(themes, { prompt = "Select a theme to sync:" }, function(selected)
		if selected then
			M.set_colorscheme(selected)
		end
	end)
end

return M
