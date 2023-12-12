-- see: https://wezfurlong.org/wezterm/config/files.html

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.enable_wayland = false

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 18.0

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  -- smart copy
  {
    key="c",
    mods="CTRL",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(
          wezterm.action{CopyTo="ClipboardAndPrimarySelection"},
          pane)
        window:perform_action("ClearSelection", pane)
      else
        window:perform_action(
          wezterm.action{SendKey={key="c", mods="CTRL"}},
          pane)
      end
    end)
  },
  -- paste
  {
    key="v",
    mods="CTRL",
    action = wezterm.action.PasteFrom "Clipboard",
  },
}

-- For example, changing the color scheme:
--config.color_scheme = 'AdventureTime'

-- and finally, return the configuration to wezterm
return config
