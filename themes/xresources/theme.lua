---------------------------
-- Xresources Awesome Theme
-- Edited by: Solace_Greyowl
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local naughty = require("naughty")
local confdir = gfs.get_xdg_config_home() .. "awesome/"
local awesome_themes = confdir .. "themes/"
local theme_path = awesome_themes .. "xresources"

local theme = {}
theme.panel_height = 26
theme.wallpaper = theme_path.."/background.png"
theme.wallpaper_portrait = theme_path.."/background_portrait.png"
theme.wallpapers = {theme_path.."/backgroundcenter.png",theme_path.."/backgroundright.png",theme_path.."/backgroundleft.png"}

theme.font          = "Fira Code 9"

theme.color = {
    background      = xrdb.background,
    alt_background  = "#32302f", -- Xresources soft contrast
    selected        = xrdb.foreground,
    alert           = xrdb.color1,
    focused         = xrdb.color11,
    selected_text   = xrdb.foreground,
    unselected      = xrdb.color7,
}

theme.bg_normal     = theme.color.alt_background
theme.bg_focus      = theme.color.background
theme.bg_urgent     = theme.color.alert
theme.bg_minimize   = theme.color.background
theme.bg_systray    = theme.color.bg_normal

theme.fg_normal     = theme.color.selected_text
theme.fg_focus      = theme.color.selected_text
theme.fg_urgent     = theme.color.background
theme.fg_minimize   = theme.color.selected_text
theme.fg_systray    = theme.color.selected_text

theme.border_width  = dpi(2)
--theme.useless_gap   = dpi(10)
theme.border_normal = theme.color.bg_normal
theme.border_focus  = theme.color.selected
theme.border_marked = theme.bg_urgent

theme.titlebar_bg_focus = theme.color.bg_focus
theme.titlebar_fg_focus = theme.color.fg_focus

theme.taglist_bg_focus = "png:"..theme_path .. "/taglist/taglist_sel.png"
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_fg_focus = theme.color.selected_text
theme.taglist_fg_urgent = theme.fg_urgent

theme.tasklist_bg_focus = "png:"..theme_path .. "/taglist/tasklist_sel.png"
theme.tasklist_fg_focus = theme.color.fg_normal
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = true

theme.hotkeys_modifiers_fg = xrdb.color7

theme.tooltip_border_color = theme.fg_normal
theme.tooltip_fg = theme.fg_normal

theme.notification_font = "Fira Code 10"
--theme.notification_width = 275
theme.notification_height = 70
theme.notification_icon_size = 1
theme.notification_bg = theme.color.background
theme.notification_fg = theme.color.foreground

naughty.config.presets.critical = {
    fg = theme.fg_normal,
    bg = theme.bg_normal,
    border_width = 1,
    border_color = "#ff0000",
    timeout = 0
}

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)


-- Define the image to load
theme.titlebar_close_button_normal = theme_path.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_path.."/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme_path.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme_path.."/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_path.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_path.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_path.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_path.."/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_path.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_path.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_path.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_path.."/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_path.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_path.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_path.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_path.."/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_path.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_path.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_path.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_path.."/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
--theme.layout_fairh = theme_path.."/layouts/fairhw.png"
--theme.layout_fairv = theme_path.."/layouts/fairvw.png"
--theme.layout_floating  = theme_path.."/layouts/floatingw.png"
--theme.layout_magnifier = theme_path.."/layouts/magnifierw.png"
--theme.layout_max = theme_path.."/layouts/maxw.png"
--theme.layout_fullscreen = theme_path.."/layouts/fullscreenw.png"
--theme.layout_tilebottom = theme_path.."/layouts/tilebottomw.png"
--theme.layout_tileleft   = theme_path.."/layouts/tileleftw.png"
--theme.layout_tile = theme_path.."/layouts/tilew.png"
--theme.layout_tiletop = theme_path.."/layouts/tiletopw.png"
--theme.layout_spiral  = theme_path.."/layouts/spiralw.png"
--theme.layout_dwindle = theme_path.."/layouts/dwindlew.png"
--theme.layout_cornernw = theme_path.."/layouts/cornernww.png"
--theme.layout_cornerne = theme_path.."/layouts/cornernew.png"
--theme.layout_cornersw = theme_path.."/layouts/cornersww.png"
--theme.layout_cornerse = theme_path.."/layouts/cornersew.png"

-- Panel Widgets
theme.widget = {}

-- Layoutbox
theme.widget.layoutbox = {
    micon = awesome_themes.."submenu.png",
    color = theme.color
}

theme.widget.layoutbox.icon = {
	floating          = theme_path .. "/layouts/floating.svg",
	max               = theme_path .. "/layouts/max.svg",
	fullscreen        = theme_path .. "/layouts/fullscreen.svg",
	tilebottom        = theme_path .. "/layouts/tilebottom.svg",
	tileleft          = theme_path .. "/layouts/tileleft.svg",
	tile              = theme_path .. "/layouts/tile.svg",
	tiletop           = theme_path .. "/layouts/tiletop.svg",
	fairv             = theme_path .. "/layouts/fair.svg",
	fairh             = theme_path .. "/layouts/fair.svg",
	grid              = theme_path .. "/layouts/grid.svg",
	usermap           = theme_path .. "/layouts/map.svg",
	magnifier         = theme_path .. "/layouts/magnifier.svg",
	cornerne          = theme_path .. "/layouts/cornerne.svg",
	cornernw          = theme_path .. "/layouts/cornernw.svg",
	cornerse          = theme_path .. "/layouts/cornerse.svg",
	cornersw          = theme_path .. "/layouts/cornersw.svg",
        treetile          = confdir    .. "/treetile/layout_icon.png",
	unknown           = theme_path .. "/common/unknown.svg",
}

theme.widget.layoutbox.name_alias = {
    floating    = "Floating",
    magnifier   = "Magnifier",
    fairv       = "Fair Tile",
    max         = "Maximized",
    grid        = "Grid",
    usermap     = "User Map"
}
-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.color.bg_focus, theme.color.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "suru-plus-aspormauros"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
