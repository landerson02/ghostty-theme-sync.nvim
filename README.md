# ghostty-theme-sync.nvim

A Neovim plugin allows you to synchronize themes between Neovim and [Ghostty](https://ghostty.org/), ensuring a consistent look between terminal and editor.

### Installation
Use your favorite plugin manager, for example with [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'landerson02/ghostty-theme-sync.nvim',
  config = function()
    require('ghostty-theme-sync').setup({
      -- Add your configuration here
    })
  end
}
```

### Requirements
- Ghostty

### Usage
run the command `:GhosttyTheme` to open the theme selection menu.

### Configuration
The following options are the default:
> [!NOTE]
> You will likely need to change your Ghostty config path
```lua
{
  -- Path to your Ghostty config file
  ghostty_config_path = "~/.config/ghostty/config",
}
```
