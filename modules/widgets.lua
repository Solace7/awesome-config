local awful = require("awful")
local wibox = require("wibox")
local redflat = require("redflat")
local beautiful = require("beautiful")
local gears = require("gears")

--Include plugins from lain library
local lain = require("lain")

local widgets = {}

-------------------------
-------{{WIDGETS}}-------
-------------------------

function widgets:init(args)
    local args = args or {}
    local env = args.env

    -- Separator Widget
    self.widgetseparator = wibox.widget.textbox(" | ")
    
    -- Keyboard map indicator and switcher
    self.mykeyboardlayout = awful.widget.keyboardlayout()
    
    -- Create a textclock widget
    self.mytextclock = wibox.widget.textclock("%H:%M:%S § %Y-%m-%d",1)

    self.monthcal = awful.widget.calendar_popup.month()
    self.monthcal:attach(self.mytextclock,"tm" ,{on_hover=false})

    -- CPU Governor Widget
    cpugovs = {
        { "performance", function() awful.spawn('gksu "cpupower frequency-set -g performance"') end },
        { "powersave", function() awful.spawn('gksu "cpupower frequency-set -g powersave"') end },
    }
    cpugovmenu = awful.menu({ items = { {"governors", cpugovs }

                                     }
                            })

    self.cpugovernor = awful.widget.watch('cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor', 60, function(widget, stdout)
        for line in stdout:gmatch("[^\r\n]+") do
            if line:match("performance") then 
                widget:set_image(env.themedir .. "/cpu-frequency-indicator-performance.svg")
            else if line:match("powersave") then
                widget:set_image(env.themedir .. "/cpu-frequency-indicator-powersave.svg")
            else
                widget:set_image(env.themedir .. "/cpu-frequency-indicator.svg")
                end
            end
            cpugov_t = awful.tooltip({
                objects = { cpugovernor },
                timer_function = function()
                    return line
                end,
            })
        end
    end, wibox.widget.imagebox())
    
    self.cpugovernor:buttons(gears.table.join(
                    awful.button({ }, 3, function() cpugovmenu:toggle() end)
                    ))

    adbdevicelist = {
                      {"..."}
                    }

    adbdevicelist[0] = {"check adb devices"}

    -- ADB Android Menu Widget
    self.adbdevicemenu = awful.widget.watch('adb devices | grep devices$ | awk "{print $1}"', 60, function(widget, stdout)
        widget:set_image(env.themedir .. "/mobile-screen.svg")
        for line in stdout:gmatch("[^\r\n]+") do
            adbdevicelist[#line] = { line }
        end
        end, wibox.widget.imagebox())
    
    gears.timer {
      timeout   = 10,
      call_now  = true,
      autostart = true,
      callback  = function()
        awful.spawn.easy_async(
        {'bash -c "adb devices -l | grep product"'},
        function(out)
          if #out >= 1 then
           for k,v in pairs(out) do
              device = out[k]
              adbdevicelist[k] = { device, function() awful.spawn(scriptsdir .. 'bin/adbscrcpy' .. device) end }
            end
          else
            adbdevicelist[0] = {"no devices available"}
          end
        end
        ) 
      end
    }
    adbdevicemenu = awful.menu({items = {{"devices", adbdevicelist}
                                        }
                               })
    self.adbdevicemenu:buttons(gears.table.join(
                    awful.button({ }, 3, function() adbdevicemenu:toggle() end)
                    ))

    --Systemtray widget
    self.systemtray = wibox.widget.systray()

    --{{Network widget
    local wifi_icon = wibox.widget.imagebox()
    local eth_icon = wibox.widget.imagebox()
    local nm = lain.widget.net({
            notify = "on",
            wifi_state = "on",
            eth_state = "on",
        settings = function()
            local eth0 = net_now.devices.enp3s0
            if eth0 then
                if eth0.ethernet then
                    eth_icon:set_image(env.icon_dir .. "/status/symbolic/network-wired-symbolic.svg")
                else
                    eth_icon:set_image()
                end
            end
            local wlan0 = net_now.devices["wlp0s26u1u2"]
            if wlan0 then
                if wlan0.wifi then
                    local signal = wlan0.signal
                    if signal < -83 then
                        wifi_icon:set_image(env.icon_dir .. "/status/symbolic/network-wireless-signal-weak-symbolic.svg")
                    elseif signal < -70 then
                        wifi_icon:set_image(env.icon_dir .. "/status/symbolic/network-wireless-signal-ok-symbolic.svg")
                    elseif signal < -53 then
                        wifi_icon:set_image(env.icon_dir .. "/status/symbolic/network-wireless-signal-good-symbolic.svg")
                    elseif signal >= -53 then
                        wifi_icon:set_image(env.icon_dir .. "/status/symbolic/network-wireless-signal-excellent-symbolic.svg")
                    else
                        wifi_icon:set_image(env.icon_dir .. "/status/symbolic/network-wireless-offline-symbolic.svg")
                    end
                else
                    wifi_icon:set_image(env.icon_dir .. "/status/symbolic/network-wireless-offline-symbolic.svg")
                end
            end
        end
    })
    self.wifi_icon = wifi_icon
    self.eth_icon = eth_icon

    wifi_icon:buttons(gears.table.join(
        awful.button({}, 1, function() awful.spawn.with_shell("networkmanager_dmenu") end)))
     
    self.watchpacman = wibox.widget.imagebox()
--[[    
    local paccheck = awful.widget.watch('pacman -Qu | grep -v ignored | wc -l ', 60, function(widget, stdout)
            if tonumber(stdout) > 0 then 
                awful.spawn("notify-send 'There are '" .. line .. "' package(s) to be upgraded ' ")
                watchpacman:set_image(env.icon_dir .. "/apps/symbolic/aptdaemon-upgrade-symbolic.svg")
            else
                awful.spawn("notify-send 'all good' ")
                watchpacman:set_image(env.icon_dir .. "/status/symbolic/software-update-available-symbolic.svg")
            end
            watchpacman_t = awful.tooltip({
                objects = { self.watchpacman },
                timer_function = function()
                    return stdout
                end,
            })
    end)
    ]]--
    
    --Volume widget
    local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
    
    self.vol_widget = volume_widget{
      widget_type = 'icon_and_text'
    }

    self.volume = lain.widget.alsa({
        cmd = "amixer",
        channel = "Master",
        settings = function()
            widget:set_markup(" VOL " .. volume_now.level .. "%")
        end
    })
    
    -- IP address widget
    local address_device="enp6s0"
    self.address_widget = awful.widget.watch('bash -c \"ip -4 -o a | grep ' .. address_device .. '| awk \'{print $4}\'\"', 60, function(widget, stdout)
      for line in stdout:gmatch("[^\r\n]+") do
        widget:set_markup('<span color="#1d2021">' .. address_device .. ": " .. line .. '</span>')
      end
        return
    end)

    -- Uptime widget
    self.uptimewidget = awful.widget.watch('bash -c \"uptime -p\"', 60, function (widget,stdout)
      for line in stdout:gmatch("[^\r\n]+") do
        widget:set_markup(line)
      end
    end) 

    --Temperature widget
    local tempsensordevice="k10temp-pci-00c3"
    self.tempsensorwidget = awful.widget.watch('bash -c \"sensors | awk \'/' .. tempsensordevice ..'/{f=1} f && /Tctl/{print $2; f=0}\' | cut -c 2-5"',60, function(widget, stdout)
      for line in stdout:gmatch("[^\r\n]+") do
        if tonumber(line) > 60 then
          widget:set_markup('<span color="#FB4934">' .. line .. "°C" .. '</span>')
        else 
          widget:set_markup(line .. "°C")
        end
        return
      end
    end)
    
        -- We need one layoutbox per screen.
        self.layoutbox = {}
             self.layoutbox.buttons = awful.util.table.join(
                                      awful.button({ }, 1, function () awful.layout.inc( 1) end),
                                      awful.button({ }, 3, function () redflat.widget.layoutbox:toggle_menu(mouse.screen.selected_tag) end),
                                      awful.button({ }, 4, function () awful.layout.inc( 1) end),
                                      awful.button({ }, 5, function () awful.layout.inc(-1) end))               
    end
return widgets
