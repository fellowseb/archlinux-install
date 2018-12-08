local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gfs = require("gears.filesystem")
local shape = require("gears.shape")
local wallpaper = require("gears.wallpaper")
local dpi = xresources.apply_dpi
local themes_path = gfs.get_themes_dir()

local theme = {}
local this_theme_path = "~/.config/awesome/themes/fellowseb/"

theme.font          = "Inconsolata Nerd Font 11"

theme.bg_normal     = "#665e49"
theme.bg_focus      = "#55bcce"
theme.bg_focus      = "#997009"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = "#FF0000"

theme.fg_normal     = "#dedede"
theme.fg_focus      = "#282722"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(2)
theme.border_normal = "#000000"
theme.border_normal = "#272822"
theme.border_focus  = "#56b7a5"
theme.border_focus  = "#997009"
theme.border_marked = "#91231c"

theme.tasklist_bg_focus = "#665e49"
theme.tasklist_fg_focus = "#272822"
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
theme.tooltip_border_width = dpi(1)
theme.tooltip_opacity = 0.9 
theme.tooltip_bg = "#fefefe"
theme.tooltip_border_color = "#272822"
theme.tooltip_shape = shape.infobubble
theme.hotkeys_opacity = 0.95
theme.hotkeys_bg = "#272822"
theme.hotkeys_modifiers_fg = "#FEFEFE"
theme.hotkeys_label_fg = "#272822"
theme.hotkeys_fg = "#DDDDDD"
theme.hotkeys_border_width = dpi(1)
theme.hotkeys_border_color = "#999999"
-- theme.hotkeys_bg = "#999999"
-- Example:
theme.taglist_shape = shape.rounded_rect
theme.taglist_shape_border_width = dpi(1)
theme.taglist_shape_border_color = "#272822"
theme.taglist_bg_empty = "#665e49"
theme.taglist_bg_focus = "#272822"
theme.taglist_fg_focus = "#997009"
theme.taglist_fg_empty = "#272822"
theme.taglist_fg_occupied = "#665e49"
theme.taglist_bg_occupied = "#272822"
theme.taglist_bg_urgent = "#fa2772"
theme.taglist_spacing = dpi(2)
theme.tasklist_shape_border_width = dpi(4)
theme.tasklist_shape_border_color = "#ffffff"
-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.tasklist_fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.tasklist_fg_normal
)

theme.titlebar_bg_normal = "#272822"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
theme.menu_bg_normal = "#997009"
theme.menu_border_color = "#997009"
theme.menu_border_width = dpi(1)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = this_theme_path.."close.svg"
theme.titlebar_close_button_focus  = this_theme_path.."close_focus.svg"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = this_theme_path.."ontop_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = this_theme_path.."ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = this_theme_path.."ontop_active.svg"
theme.titlebar_ontop_button_focus_active  = this_theme_path.."ontop_focus_active.svg"

theme.titlebar_sticky_button_normal_inactive  = this_theme_path.."sticky_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = this_theme_path.."sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active  = this_theme_path.."sticky_active.svg"
theme.titlebar_sticky_button_focus_active  = this_theme_path.."sticky_focus_active.svg"

theme.titlebar_floating_button_normal_inactive  = this_theme_path.."floating_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = this_theme_path.."floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active  = this_theme_path.."floating_active.svg"
theme.titlebar_floating_button_focus_active  = this_theme_path.."floating_focus_active.svg"

theme.titlebar_maximized_button_normal_inactive = this_theme_path.."maximized_inactive.svg"
theme.titlebar_maximized_button_focus_inactive = this_theme_path.."maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active  = this_theme_path.."maximized_active.svg"
theme.titlebar_maximized_button_focus_active  = this_theme_path.."maximized_focus_active.svg"

wallpaper.centered("/home/seb/.config/awesome/themes/fellowseb/archlinux_logo.svg", nil, "#665e49", 2)

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)
theme.menu_icon = "~/.config/awesome/themes/fellowseb/menu_bars.svg"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
