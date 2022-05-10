--Updated to 1.59 by bookfdafaa7b

-- originally by hotline
-- github.com/hotline1337

require("lib/natives")

function mpx()
	return "MP" .. script_global:new(1574915):get_int64() .. "_"
end

system.fiber(function()
    STATS.STAT_SET_INT(string.smart_joaat(mpx() .. "CLUB_POPULARITY"), 1000)
    utils.notify("Nightclub Popularity", "Successfully changed your club popularity to max", 28, 1)
end)
