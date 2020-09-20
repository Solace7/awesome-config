--Acquire environment
local awful = require("awful")
local gears = require("gears")

local autostart = {}

------------------------------------------
-------}}}Autostart Applications{{{-------
------------------------------------------

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

function autostart:run(args)
    local args = args or {}
    local env = args.env

    --}}}Background Stuff {{{--
    
    --Run only once
    run_once("picom --config " .. gears.filesystem.get_xdg_config_home() .."/picom.conf")
    run_once("sh /home/grey/.config/conky/solui.sh")
    run_once(gears.filesystem.get_xdg_config_home() .. "conky/solui.sh")
    run_once("/usr/lib/xfce-polkit/xfce-polkit")
--    run_once("synergy")
    run_once(env.scriptsdir .. "/bin/rxvtconf.sh")
--    run_once("/home/greyowl/.screenlayout/default.sh")
    
    --}}} COMMS Workspace {{{--
    commsrun = true
    commsStartup = {
    	"discord",
        "skype",
    }
    if commsrun then
    	for app = 1, #commsStartup do
    		run_once(commsStartup[app])
    	end
        commsrun = false
    end
end

return autostart
