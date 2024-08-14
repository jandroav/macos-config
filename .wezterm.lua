-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Disable dead keys - https://en.wikipedia.org/wiki/Dead_key
config.use_dead_keys = false

-- my dracula colorscheme
config.color_scheme = "Dracula (Official)"

-- my custom font and size (nerd font)
config.font = wezterm.font("MesloLGS NF")
config.font_size = 14

-- tab bar configurations
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- window configurations
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.70
config.macos_window_background_blur = 10

-- Maximize on startup
wezterm.on('gui-startup', function()
  local tab, pane, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

-- hyperlink rules with defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make task numbers clickable
-- the first matched regex group is captured in $1.
-- datical jira task numbers are in the format [DAT]-1234
table.insert(config.hyperlink_rules, {
    regex = [[\b(DAT|PRM)-\d+\b]],
    format = 'https://datical.atlassian.net/browse/$1',
})

-- make github links clickable
table.insert(config.hyperlink_rules, {
    regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
    format = 'https://www.github.com/$1/$3',
})

table.insert(config.hyperlink_rules, {
    regex = '\\((\\w+://\\S+)\\)',
    format = '$1',
    highlight = 1,
})

table.insert(config.hyperlink_rules, {
    regex = '\\[(\\w+://\\S+)\\]',
    format = '$1',
    highlight = 1,
})

table.insert(config.hyperlink_rules, {
    regex = '\\{(\\w+://\\S+)\\}',
    format = '$1',
    highlight = 1,
})

table.insert(config.hyperlink_rules, {
    regex = '<(\\w+://\\S+)>',
    format = '$1',
    highlight = 1,
})

table.insert(config.hyperlink_rules, {
    regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
    format = '$0',
})

table.insert(config.hyperlink_rules, {
    regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
    format = 'mailto:$0',
})
-- rename tab
-- add this to your .zshrc or .bashrc to set the tab title
-- function rename_wezterm_title {
--  echo "\x1b]1337;SetUserVar=panetitle=$(echo -n $1 | base64)\x07"
-- }
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane_title = tab.active_pane.title
  local user_title = tab.active_pane.user_vars.panetitle

  if user_title ~= nil and #user_title > 0 then
    pane_title = user_title
  end

  return {
    {Text=" " .. pane_title .. " "},
  }
end)

-- and finally, return the configuration to wezterm
return config
