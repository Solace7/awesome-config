--Acquire environment
local awful = require("awful")
local beautiful = require("beautiful")

local signals = {}

local function do_sloppy_focus(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
        client.focus = c
    end
end

function signals:listen(args)
    local args = args or {}
    local env = args.env

    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", env.wallpaper)
    
    -- Signal function to execute when a new client appears.
    client.connect_signal("manage", function (c)
        
        --put client at the end of list
        if env.set_slave then awful.client.setslave(c) end

        if awesome.startup 
          and not c.size_hints.user_position
          and not c.size_hints.program_position 
        then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end) 

    if env.sloppy_focus then 
        client.connect_signal("mouse::enter", do_sloppy_focus)
    end

    if env.color_border then
        client.connect_signal("focus",  function(c) c.border_color = beautiful.border_focus end)
        client.connect_signal("unfocus",function(c) c.border_color = beautiful.border_normal end)
    end

    --move clients from disconnected screen to connected screen
    tag.connect_signal("request::screen", function(t)
        awful.spawn("notify-send -u critical 'Screen Disconnected' ")
        for s in screen do
            if (s ~= t.screen) then
                local t2 = awful.tag.find_by_name(s,t.name)
                if(t2) then
                    t:swap(t2)
                else
                    t.screen = s
                end
                return
            end
        end 
    end)
    --Screen handling
    screen.connect_signal("list", function() awful.spawn("/home/sgreyowl/.config/scripts/display_setup.sh") end )
   
end



return signals
