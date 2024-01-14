-- ~/.config/wezterm/wezterm.lua
-- New-Item -Path $home\.config\wezterm -ItemType SymbolicLink -Value $(Resolve-Path .)
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local launch_menu = {}

local is_linux = function()
  return wezterm.target_triple:find("linux") ~= nil
end

local is_darwin = function()
  return wezterm.target_triple:find("darwin") ~= nil
end

local is_windows = function()
  return wezterm.target_triple:find("windows") ~= nil
end

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.adjust_window_size_when_changing_font_size = false

config.window_frame = {
  border_bottom_height = '1px',
  border_bottom_color = 'black',
}

config.window_padding = {
  top = '0',
  bottom = '0',
}

wezterm.on('gui-startup', function()
  local tab, pane, window = wezterm.mux.spawn_window{}
  window:gui_window():maximize()
end)

config.font = wezterm.font('Hack Nerd Font', { weight = 'Regular' })
config.font_size = 13
config.cell_width = 1.0
config.color_scheme = 'Sprinkles'
config.freetype_load_flags = 'FORCE_AUTOHINT'
config.line_height = 1.1

config.keys = {
  {
    key = 'v',
    mods = 'CTRL',
    action = wezterm.action { PasteFrom = "Clipboard" },
  },
  {
    key = 'v',
    mods = 'SUPER',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'c',
    mods = 'SUPER',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SendKey { key = 'v', mods = 'CTRL' },
  },
}

if is_windows() then
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
end

return config
