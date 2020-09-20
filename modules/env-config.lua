-----------------------------------------------------------------------------------------------------------------------
--                                                  Environment config                                               --
-----------------------------------------------------------------------------------------------------------------------

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local redflat = require("redflat")

-------DONT LOAD NAUGHTY------- 2018-12-05, I'm gonna see how I like naughty over dunst
--local _dbus = dbus; dbus = nil
local naughty = require("naughty")
--dbus = _dbus

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local env = {}

-- Build hotkeys depended on config parameters
-----------------------------------------------------------------------------------------------------------------------
function env:init(args)

	-- init vars
	local args = args or {}
	local theme = args.theme or "default"

	-- environment vars
	self.terminal = args.terminal or "urxvt"
    self.editor = args.editor or "vim"
	self.mod = args.mod or "Mod4"
	self.fm = args.fm or "nemo"
	self.home = os.getenv("HOME")
    self.config = gears.filesystem.get_xdg_config_home()
	self.themedir = awful.util.get_configuration_dir() .. "themes/" .. theme
    self.scriptsdir = self.config .. "scripts/"

	self.sloppy_focus = false
	self.color_border = false
	self.set_slave = false

	-- theme setup
	beautiful.init(env.themedir .. "/theme.lua")
    self.icon_dir = "/usr/share/icons/Suru++-Asprómauros"
end
-- Wallpaper setup
--------------------------------------------------------------------------------
env.wallpaper = function(s)
	if beautiful.wallpaper then
		if awful.util.file_readable(beautiful.wallpaper) then
            --if s.geometry.width == 1080 then
            --    gears.wallpaper.maximized(beautiful.wallpaper_portrait, s, true)
            --else
			    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
            --end
		else
			gears.wallpaper.set(beautiful.color.bg)
		end
	end
end

-- Tag tooltip text generation
--------------------------------------------------------------------------------
env.tagtip = function(t)
	local layname = awful.layout.getname(awful.tag.getproperty(t, "layout"))
	if redflat.util.table.check(beautiful, "widget.layoutbox.name_alias") then
		layname = beautiful.widget.layoutbox.name_alias[layname] or layname
	end
	return string.format("%s (%d apps) [%s]", t.name, #(t:clients()), layname)
end

-- Panel widgets wrapper
--------------------------------------------------------------------------------
env.wrapper = function(widget, name, buttons)
	local margin = redflat.util.table.check(beautiful, "widget.wrapper") and beautiful.widget.wrapper[name]
	               and beautiful.widget.wrapper[name] or { 0, 0, 0, 0 }
	if buttons then
		widget:buttons(buttons)
	end

	return wibox.container.margin(widget, margin)
end


-- End
-----------------------------------------------------------------------------------------------------------------------
return env
