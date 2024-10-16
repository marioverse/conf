-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- my coolnight colorscheme
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
  selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- specify the font make sure the choosen font is installed
--config.font = wezterm.font("MesloLGS Nerd Font Mono", weight = "Regular" )
--config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font = wezterm.font("FiraCode Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"})
--config.font = wezterm.font("JetBrains Mono")
config.font_size = 15

-- don't show tab_bar 
config.enable_tab_bar = false

-- let's us resize the terminal window
config.window_decorations = "RESIZE"
-- reduce the background color  and add a little blur effect
config.window_background_opacity = 0.75
config.macos_window_background_blur = 10

-- Enable interpretation of curly brackets and other symbols with option key
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- and finally, return the configuration to wezterm
return config
