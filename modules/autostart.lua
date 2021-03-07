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
    run_once("picom --config " .. env.config .. "picom.conf")
    run_once("/usr/lib/xfce-polkit/xfce-polkit")
    run_once("barrier")
    run_once("/home/greyowl/.screenlayout/default.sh")
    run_once("autoadb scrcpy -s '{}'")
    
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
