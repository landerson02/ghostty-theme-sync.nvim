# ghostty-theme-sync.nvim

A Neovim plugin allows you to synchronize themes between Neovim and [Ghostty](https://ghostty.org/), ensuring a consistent look between terminal and editor.

### Installation
Use your favorite plugin manager, for example with [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'landerson02/ghostty-theme-sync.nvim',
  --- @type GhosttySyncConfig
  opts = {
    -- Add your configuration here
  },
}
```

### Requirements
- Ghostty

### Usage
Run the command `:GhosttyTheme` to open the theme selection menu.

After selecting a new theme, you will need to refresh your ghostty config with `cmd+shift+,` or `ctrl+shift+,` on MacOS and Linux respectively.
> [!WARNING]
> Some ghostty themes have a slightly different name than its nvim counterpart, so there is a translation table in translations.lua.
> If you find a theme that is not supported, please open an issue or a PR.

### Configuration
The following options are the default:
> [!NOTE]
> You may need to change your Ghostty config path
```lua
{
  -- Path to your Ghostty config file
  ghostty_config_path = "~/.config/ghostty/config",

  -- If you want to keep the nvim colorscheme change (like the ghostty change),
  -- set this to true and point the config path to your config file that contains
  -- a line of the form: `vim.cmd.colorscheme('<colorscheme>')`
  -- The plugin will change this line to the selected theme
  persist_nvim_theme = false,
  nvim_config_path = "",
}
```
