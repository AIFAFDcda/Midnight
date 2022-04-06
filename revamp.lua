SET_GLOBAL = {
	int = function(global, value)
		script_global:new(global):set_int64(value)
	end,
	float = function(global, value)
		script_global:new(global):set_float(value)
	end
}

function mpx()
	return "MP" .. script_global:new(1574907):get_int64() .. "_"
end



function add_to_history(player, message, scope)
	system.fiber(function(callback)
		local chat_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("multiplayer_chat")
		GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(chat_scaleform, 255, 255, 255, 255, 0)
		GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(chat_scaleform, "ADD_MESSAGE")
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(player)
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(message)
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(scope)
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
	end)
end

function set_statTable(statTable) 
	for _,v in pairs(statTable) do 
		if string.match(v[1], "MPPLY") then
			system.fiber(function(callback)
   			STATS.STAT_SET_INT(MISC.GET_HASH_KEY(v[1]), v[2], true)
			end)
		else
			system.fiber(function(callback)
    			STATS.STAT_SET_INT(MISC.GET_HASH_KEY(mpx() .. v[1]), v[2], true)
			end)
	    end
	end
	return true
end


function OnChatMsg(pid, message_text)
	system.fiber(function(callback) if pid ~=  PLAYER.PLAYER_ID() then return end end)
	if message_text:lower():find("^!nocheat") ~= nil then
		local statTableReport = { {"MPPLY_FRIENDLY", 100},{"MPPLY_HELPFUL", 100}, {"MPPLY_COMMEND_STRENGTH", 16}, {"MPPLY_REPORT_STRENGTH", 16}, {"MPPLY_GRIEFING", 0}, {"MPPLY_GAME_EXPLOITS", 0}, {"MPPLY_EXPLOITS", 0}, {"MPPLY_BAD_CREW_STATUS", 0}, {"MPPLY_OFFENSIVE_LANGUAGE", 0}, {"MPPLY_VC_HATE", 0}, {"MPPLY_VC_ANNOYINGME", 0}, {"MPPLY_OFFENSIVE_TAGPLATE", 0}, {"MPPLY_OFFENSIVE_UGC", 0}, {"MPPLY_PLAYERMADE_DESC", 0}, {"MPPLY_PLAYERMADE_TITLE", 0}, {"MPPLY_BAD_CREW_EMBLEM", 0}, {"MPPLY_BAD_CREW_MOTTO", 0}, {"MPPLY_BAD_CREW_NAME", 0}, {"MPPLY_BAD_CREW_STATUS", 0}, {"MPPLY_IS_CHEATER", 0}, {"MPPLY_IS_CHEATER_TIME", 0}, {"SCADMIN_IS_CHEATER", 0}, {"MPPLY_BECAME_CHEATER_DT", 0}, {"MPPLY_BECAME_CHEATER_NUM", 0}, {"MPPLY_WAS_I_CHEATER", 0}, {"TIMES_CHEATED", 0}, {"CHEAT_BITSET", 0}, {"DESTROYED_PVEHICLES", 0}, {"MPPLY_LAST_REPORT_PENALTY", 0}, {"MPPLY_LTS_CHEAT_END", 0}, {"MPPLY_LTS_CHEAT_QUIT", 0}, {"MPPLY_LTS_CHEAT_START", 0}, {"MPPLY_LTS_CHEAT_TALLY", 0}, {"MPPLY_DROPOUTRATE", 0}, {"MPPLY_MGAME_CHEAT_END", 0}, {"MPPLY_MGAME_CHEAT_QUIT", 0}, {"MPPLY_MGAME_CHEAT_START", 0}, {"MPPLY_MGAME_CHEAT_TALLY", 0}, {"MPPLY_MC_CHEAT_END", 0}, {"MPPLY_MC_CHEAT_QUIT", 0}, {"MPPLY_MC_CHEAT_START", 0}, {"MPPLY_MC_CHEAT_TALLY", 0}, {"MPPLY_PARA_CHEAT_END", 0}, {"MPPLY_PARA_CHEAT_QUIT", 0}, {"MPPLY_PARA_CHEAT_START", 0}, {"MPPLY_PARA_CHEAT_TALLY", 0}, {"MPPLY_RACE_CHEAT_END", 0}, {"MPPLY_RACE_CHEAT_QUIT", 0}, {"MPPLY_RACE_CHEAT_START", 0}, {"MPPLY_RACE_CHEAT_TALLY", 0}, {"MPPLY_CAP_CHEAT_END", 0}, {"MPPLY_CAP_CHEAT_QUIT", 0}, {"MPPLY_CAP_CHEAT_START", 0}, {"MPPLY_CAP_CHEAT_TALLY", 0}, {"MPPLY_SUR_CHEAT_END", 0}, {"MPPLY_SUR_CHEAT_QUIT", 0}, {"MPPLY_SUR_CHEAT_START", 0}, {"MPPLY_SUR_CHEAT_TALLY", 0}, {"MPPLY_FMEVN_CHEAT_END", 0}, {"MPPLY_FMEVN_CHEAT_QUIT", 0}, {"MPPLY_FMEVN_CHEAT_START", 0}, {"MPPLY_FMEVN_CHEAT_TALLY", 0}, {"MPPLY_VOTED_OUT", 0}, {"MPPLY_VOTED_OUT_DELTA", 0}, {"MPPLY_VOTED_OUT_QUIT", 0}, {"MPPLY_OVERALL_CHEAT", 0}, }
		if set_statTable(statTableReport) then
			add_to_history("Admin", "Removed Cheater Stats", "Revamped Recovery")
		end
	return
	end

	if message_text:lower():find("^!alientattoo") ~= nil then
	system.fiber(function(callback)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
			STATS.STAT_SET_INT(MISC.GET_HASH_KEY(mpx() .. 'TATTOO_FM_CURRENT_32'), 32768, true)
		else
			STATS.STAT_SET_INT(MISC.GET_HASH_KEY(mpx() .. 'TATTOO_FM_CURRENT_32'), 67108864, true)
		end
		add_to_history("Admin", "Applied Alien Tattoo", "Revamped Recovery")
		lobby.change_session(10)
	end)
	return
	end
	if message_text:lower():find("^!unlockxmasliveries") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	system.fiber(function(callback)
		if input ~= nil then
			if input == "on" then
				for i=0,20 do 
					STATS.STAT_SET_BOOL(MISC.GET_HASH_KEY('MPPLY_XMASLIVERIES' .. i), true, true)
				end
				add_to_history("Admin", "Unlocked XMAS Liveries", "Revamped Recovery")
			elseif input == "off" then
				for i=0,20 do 
					STATS.STAT_SET_BOOL(MISC.GET_HASH_KEY('MPPLY_XMASLIVERIES' .. i), false, true)
				end
				add_to_history("Admin", "Removed XMAS Liveries", "Revamped Recovery")
			
			else
				add_to_history("Admin", "You must specify on or off example, !unlockxmasliveries on", "Revamped Recovery")
			end
		else
			add_to_history("Admin", "You must specify on or off example, !unlockxmasliveries on", "Revamped Recovery")
		end
	end)
	return
	end

	if message_text:lower():find("^!abilitiesmax") ~= nil then
	system.fiber(function(callback)

	local statTable = { {"SPECIAL_ABILITY", 100}, {"STAMINA", 100}, {"STRENGTH", 100}, {"LUNG_CAPACITY", 100}, {"WHEELIE_ABILITY", 100}, {"FLYING_ABILITY", 100}, {"SHOOTING_ABILITY", 100}, {"SCRIPT_INCREASE_STAM", 100}, {"SCRIPT_INCREASE_STRN", 100}, {"SCRIPT_INCREASE_LUNG", 100}, {"SCRIPT_INCREASE_DRIV", 100}, {"SCRIPT_INCREASE_FLY", 100}, {"SCRIPT_INCREASE_SHO", 100}, {"SCRIPT_INCREASE_STL", 100}, {"SCRIPT_INCREASE_MECH", 100}, 
			    {"CHAR_ABILITY_1_UNLCK", 1}, {"CHAR_FM_ABILITY_1_UNLCK", 1}, --idk about these didnt check freemode
			    {"CHAR_ABILITY_2_UNLCK", 1}, {"CHAR_FM_ABILITY_2_UNLCK", 1}, --idk about these didnt check freemode
			    {"CHAR_ABILITY_3_UNLCK", 1}, {"CHAR_FM_ABILITY_3_UNLCK", 1}, --idk about these didnt check freemode
	}
		if set_statTable(statTable) then
			add_to_history("Admin", "Maxed Abilities", "Revamped Recovery")
		end
	end)
	return
	end
	if message_text:lower():find("^!clubmax") ~= nil then
	system.fiber(function(callback)

	local statTable = { {"CLUB_POPULARITY", 1000}, }
		if set_statTable(statTable) then
			add_to_history("Admin", "Maxed out Night Club Popularity", "Revamped Recovery")
		end
	end)
	return
	end
	if message_text:lower():find("^!unlockmisc1") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	system.fiber(function(callback)
		if input ~= nil then
			if input == "on" then
				SET_GLOBAL.int(262145+23973, 1)
				SET_GLOBAL.int(262145+23974, 1)
				SET_GLOBAL.int(262145+23975, 1)
				SET_GLOBAL.int(262145+23976, 1)
				SET_GLOBAL.int(262145+23977, 1)
				SET_GLOBAL.int(262145+23978, 1)
				SET_GLOBAL.int(262145+23979, 1)
				SET_GLOBAL.int(262145+23980, 1)
				SET_GLOBAL.int(262145+23981, 1)
				SET_GLOBAL.int(262145+23982, 1)
				SET_GLOBAL.int(262145+23983, 1)
				SET_GLOBAL.int(262145+23984, 1)
				SET_GLOBAL.int(262145+23985, 1)
				SET_GLOBAL.int(262145+23986, 1)
				SET_GLOBAL.int(262145+23989, 1)
				SET_GLOBAL.int(262145+23990, 1)
				SET_GLOBAL.int(262145+23991, 1)
				SET_GLOBAL.int(262145+23992, 1)
				SET_GLOBAL.int(262145+23993, 1)
				SET_GLOBAL.int(262145+23994, 1)
				SET_GLOBAL.int(262145+23995, 1)
				SET_GLOBAL.int(262145+23996, 1)
				SET_GLOBAL.int(262145+23997, 1)
				SET_GLOBAL.int(262145+23998, 1)
				SET_GLOBAL.int(262145+24465, 1)
				SET_GLOBAL.int(262145+24497, 1)
				SET_GLOBAL.int(262145+24498, 1)
				SET_GLOBAL.int(262145+24499, 1)
				SET_GLOBAL.int(262145+24500, 1)
				SET_GLOBAL.int(262145+24501, 1)
				SET_GLOBAL.int(262145+24502, 1)
				SET_GLOBAL.int(262145+24503, 1)
				SET_GLOBAL.int(262145+24504, 1)
				SET_GLOBAL.int(262145+24505, 1)
				SET_GLOBAL.int(262145+24506, 1)
				SET_GLOBAL.int(262145+24507, 1)
				SET_GLOBAL.int(262145+24508, 1)
				SET_GLOBAL.int(262145+24509, 1)
				SET_GLOBAL.int(262145+24510, 1)
				SET_GLOBAL.int(262145+24511, 1)
				SET_GLOBAL.int(262145+24512, 1)
				SET_GLOBAL.int(262145+24513, 1)
				SET_GLOBAL.int(262145+24514, 1)
				SET_GLOBAL.int(262145+24515, 1)
				SET_GLOBAL.int(262145+24516, 1)
				add_to_history("Admin", "Unlocked Brand & Knockoff & Radio T-shirts", "Revamped Recovery")
			elseif input == "off" then
				SET_GLOBAL.int(262145+23973, 0)
				SET_GLOBAL.int(262145+23974, 0)
				SET_GLOBAL.int(262145+23975, 0)
				SET_GLOBAL.int(262145+23976, 0)
				SET_GLOBAL.int(262145+23977, 0)
				SET_GLOBAL.int(262145+23978, 0)
				SET_GLOBAL.int(262145+23979, 0)
				SET_GLOBAL.int(262145+23980, 0)
				SET_GLOBAL.int(262145+23981, 0)
				SET_GLOBAL.int(262145+23982, 0)
				SET_GLOBAL.int(262145+23983, 0)
				SET_GLOBAL.int(262145+23984, 0)
				SET_GLOBAL.int(262145+23985, 0)
				SET_GLOBAL.int(262145+23986, 0)
				SET_GLOBAL.int(262145+23989, 0)
				SET_GLOBAL.int(262145+23990, 0)
				SET_GLOBAL.int(262145+23991, 0)
				SET_GLOBAL.int(262145+23992, 0)
				SET_GLOBAL.int(262145+23993, 0)
				SET_GLOBAL.int(262145+23994, 0)
				SET_GLOBAL.int(262145+23995, 0)
				SET_GLOBAL.int(262145+23996, 0)
				SET_GLOBAL.int(262145+23997, 0)
				SET_GLOBAL.int(262145+23998, 0)
				SET_GLOBAL.int(262145+24465, 0)
				SET_GLOBAL.int(262145+24497, 0)
				SET_GLOBAL.int(262145+24498, 0)
				SET_GLOBAL.int(262145+24499, 0)
				SET_GLOBAL.int(262145+24500, 0)
				SET_GLOBAL.int(262145+24501, 0)
				SET_GLOBAL.int(262145+24502, 0)
				SET_GLOBAL.int(262145+24503, 0)
				SET_GLOBAL.int(262145+24504, 0)
				SET_GLOBAL.int(262145+24505, 0)
				SET_GLOBAL.int(262145+24506, 0)
				SET_GLOBAL.int(262145+24507, 0)
				SET_GLOBAL.int(262145+24508, 0)
				SET_GLOBAL.int(262145+24509, 0)
				SET_GLOBAL.int(262145+24510, 0)
				SET_GLOBAL.int(262145+24511, 0)
				SET_GLOBAL.int(262145+24512, 0)
				SET_GLOBAL.int(262145+24513, 0)
				SET_GLOBAL.int(262145+24514, 0)
				SET_GLOBAL.int(262145+24515, 0)
				SET_GLOBAL.int(262145+24516, 0)
				add_to_history("Admin", "Removed Brand & Knockoff & Radio T-shirts", "Revamped Recovery")
			
			else
				add_to_history("Admin", "You must specify on or off example, !unlockmisc1 on", "Revamped Recovery")
			end
		else
			add_to_history("Admin", "You must specify on or off example, !unlockmisc1 on", "Revamped Recovery")
		end
	end)
	return
	end

	if message_text:lower():find("^!nightclubprodtime") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	system.fiber(function(callback)
		if input ~= nil then
			if input == "on" then
				SET_GLOBAL.float(262145+24141, 0.1)
				SET_GLOBAL.int(262145+24134, 1)
				SET_GLOBAL.int(262145+24135, 1)
				SET_GLOBAL.int(262145+24136, 1)
				SET_GLOBAL.int(262145+24137, 1)
				SET_GLOBAL.int(262145+24138, 1)
				SET_GLOBAL.int(262145+24139, 1)
				SET_GLOBAL.int(262145+24140, 1)
				add_to_history("Admin", "Removed Nightclub produce time", "Revamped Recovery")
			elseif input == "off" then
				SET_GLOBAL.float(262145+24141, 0.5)
				SET_GLOBAL.int(262145+24134, 4800000)
				SET_GLOBAL.int(262145+24135, 14400000)
				SET_GLOBAL.int(262145+24136, 7200000)
				SET_GLOBAL.int(262145+24137, 2400000)
				SET_GLOBAL.int(262145+24138, 1800000)
				SET_GLOBAL.int(262145+24139, 3600000)
				SET_GLOBAL.int(262145+24140, 8400000)
				add_to_history("Admin", "Reset Nightclub produce time Default", "Revamped Recovery")
			
			else
				add_to_history("Admin", "You must specify on or off example, !nightclubprodtime on", "Revamped Recovery")
			end
		else
				add_to_history("Admin", "You must specify on or off example, !nightclubprodtime on", "Revamped Recovery")
		end
	end)
	return
	end
	if message_text:lower():find("^!unlockgifts") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	system.fiber(function(callback)
		if input ~= nil then
			if input == "on" then
				SET_GLOBAL.int(262145+12608, 1)
				SET_GLOBAL.int(262145+12607, 1)
				SET_GLOBAL.int(262145+12606, 1)
				SET_GLOBAL.int(262145+12605, 1)
				SET_GLOBAL.int(262145+9242, 1)
				SET_GLOBAL.int(262145+9241, 1)
				SET_GLOBAL.int(262145+9240, 1)
				SET_GLOBAL.int(262145+8977, 1)
				SET_GLOBAL.int(262145+23204, 1)
				SET_GLOBAL.int(262145+23203, 1)
				SET_GLOBAL.int(262145+23202, 1)
				SET_GLOBAL.int(262145+23205, 1)
				SET_GLOBAL.int(262145+23182, 1)
				SET_GLOBAL.int(262145+23181, 1)
				SET_GLOBAL.int(262145+23180, 1)
				SET_GLOBAL.int(262145+23179, 1)
				SET_GLOBAL.int(262145+23178, 1)
				SET_GLOBAL.int(262145+23177, 1)
				SET_GLOBAL.int(262145+23176, 1)
				SET_GLOBAL.int(262145+23175, 1)
				SET_GLOBAL.int(262145+23971, 1)
				SET_GLOBAL.int(262145+25488, 1)
				SET_GLOBAL.int(262145+25487, 1)
				SET_GLOBAL.int(262145+25489, 1)
				SET_GLOBAL.int(262145+25486, 1)
				SET_GLOBAL.int(262145+28340, 1)
				SET_GLOBAL.int(262145+28339, 1)
				SET_GLOBAL.int(262145+28341, 1)
				SET_GLOBAL.int(262145+28338, 1)
				SET_GLOBAL.int(262145+30536, 1)
				SET_GLOBAL.int(262145+31383, 1)
				SET_GLOBAL.int(262145+31382, 1)
				add_to_history("Admin", "Unlocked Gifts", "Revamped Recovery")
			elseif input == "off" then
				SET_GLOBAL.int(262145+12608, 0)
				SET_GLOBAL.int(262145+12607, 0)
				SET_GLOBAL.int(262145+12606, 0)
				SET_GLOBAL.int(262145+12605, 0)
				SET_GLOBAL.int(262145+9242, 0)
				SET_GLOBAL.int(262145+9241, 0)
				SET_GLOBAL.int(262145+9240, 0)
				SET_GLOBAL.int(262145+8977, 0)
				SET_GLOBAL.int(262145+23204, 0)
				SET_GLOBAL.int(262145+23203, 0)
				SET_GLOBAL.int(262145+23202, 0)
				SET_GLOBAL.int(262145+23205, 0)
				SET_GLOBAL.int(262145+23182, 0)
				SET_GLOBAL.int(262145+23181, 0)
				SET_GLOBAL.int(262145+23180, 0)
				SET_GLOBAL.int(262145+23179, 0)
				SET_GLOBAL.int(262145+23178, 0)
				SET_GLOBAL.int(262145+23177, 0)
				SET_GLOBAL.int(262145+23176, 0)
				SET_GLOBAL.int(262145+23175, 0)
				SET_GLOBAL.int(262145+23971, 0)
				SET_GLOBAL.int(262145+25488, 0)
				SET_GLOBAL.int(262145+25487, 0)
				SET_GLOBAL.int(262145+25489, 0)
				SET_GLOBAL.int(262145+25486, 0)
				SET_GLOBAL.int(262145+28340, 0)
				SET_GLOBAL.int(262145+28339, 0)
				SET_GLOBAL.int(262145+28341, 0)
				SET_GLOBAL.int(262145+28338, 0)
				SET_GLOBAL.int(262145+30536, 0)
				SET_GLOBAL.int(262145+31383, 0)
				SET_GLOBAL.int(262145+31382, 0)
				add_to_history("Admin", "Removed Gifts", "Revamped Recovery")
			
			else
				add_to_history("Admin", "You must specify on or off example, !unlockgifts on", "Revamped Recovery")
			end
		else
			add_to_history("Admin", "You must specify on or off example, !unlockgifts on", "Revamped Recovery")
		end
	end)
	return
	end
	if message_text:lower():find("^!unlocksweaters") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	system.fiber(function(callback)
		if input ~= nil then
			if input == "on" then
				SET_GLOBAL.int(262145+25558, 1)

	SET_GLOBAL.int(262145+25559, 1)
	SET_GLOBAL.int(262145+25560, 1)
	SET_GLOBAL.int(262145+25561, 1)
	SET_GLOBAL.int(262145+25562, 1)
	SET_GLOBAL.int(262145+25563, 1)
	SET_GLOBAL.int(262145+25564, 1)
	SET_GLOBAL.int(262145+25565, 1)
	SET_GLOBAL.int(262145+25566, 1)
	SET_GLOBAL.int(262145+25567, 1)

				add_to_history("Admin", "Unlocked Festive Sweaters", "Revamped Recovery")
			elseif input == "off" then
	SET_GLOBAL.int(262145+25558, 1)
	SET_GLOBAL.int(262145+25559, 1)
	SET_GLOBAL.int(262145+25560, 1)
	SET_GLOBAL.int(262145+25561, 1)
	SET_GLOBAL.int(262145+25562, 1)
	SET_GLOBAL.int(262145+25563, 1)
	SET_GLOBAL.int(262145+25564, 1)
	SET_GLOBAL.int(262145+25565, 1)
	SET_GLOBAL.int(262145+25566, 1)
	SET_GLOBAL.int(262145+25567, 1)	
				add_to_history("Admin", "Removed Festive Sweaters", "Revamped Recovery")
			
			else
				add_to_history("Admin", "You must specify on or off example, !unlocksweaters on", "Revamped Recovery")
			end
		else
			add_to_history("Admin", "You must specify on or off example, !unlocksweaterss on", "Revamped Recovery")
		end
	end)
	return
	end
	if message_text:lower():find("^!bountycut") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	if input ~= nil then
		if input == "on" then
			SET_GLOBAL.int(262145+6902, 0)
			add_to_history("Admin", "Set lesters bounty cut to 0", "Revamped Recovery")
		elseif input == "off" then
			SET_GLOBAL.int(262145+6902, 1000)
			add_to_history("Admin", "Set lesters bounty cut to 1000", "Revamped Recovery")
		else
			add_to_history("Admin", "You must specify on or off example, !bountycut on", "Revamped Recovery")
		end
		else
			add_to_history("Admin", "You must specify on or off example, !bountycut on", "Revamped Recovery")
		end
	return
	end

	if message_text:lower():find("^!xmas") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	if input ~= nil then
		if input == "on" then
			SET_GLOBAL.int(262145+4723, 1)
			SET_GLOBAL.int(262145+4734, 1)
			add_to_history("Admin", "Turned XMAS On", "Revamped Recovery")
		elseif input == "off" then
			SET_GLOBAL.int(262145+4723, 0)
			SET_GLOBAL.int(262145+4734, 0)
			add_to_history("Admin", "Turned XMAS Off", "Revamped Recovery")
		else
			add_to_history("Admin", "You must specify on or off example, !xmas on", "Revamped Recovery")
		end
		else
			add_to_history("Admin", "You must specify on or off example, !xmas on", "Revamped Recovery")
		end
	return
	end

	if message_text:lower():find("^!cayofee") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	if input ~= nil then
		if input == "on" then
			SET_GLOBAL.float(262145+29625,0)
			SET_GLOBAL.float(262145+29626,0)
			SET_GLOBAL.float(262145+29470,0) --Stolen from uc
			SET_GLOBAL.float(262145+29471,0) --Stolen from uc
			add_to_history("Admin", "Set Cayo fee to 0", "Revamped Recovery")
		elseif input == "off" then
			SET_GLOBAL.float(262145+29625, -0.1)
			SET_GLOBAL.float(262145+29626, -0.02)
			SET_GLOBAL.float(262145+29470, 0) --Stolen from uc
			SET_GLOBAL.float(262145+29471, 0) --Stolen from uc
			add_to_history("Admin", "Set Cayo fee to default", "Revamped Recovery")
		else
			add_to_history("Admin", "You must specify on or off example, !cayofee on", "Revamped Recovery")
		end
		else
			add_to_history("Admin", "You must specify on or off example, !cayofee on", "Revamped Recovery")
		end
	return
	end

	if message_text:lower():find("^!cayo100") ~= nil then
	SET_GLOBAL.int(1973496+823+56+0, 100)
	SET_GLOBAL.int(1973496+823+56+1, 100)
	SET_GLOBAL.int(1973496+823+56+2, 100)
	SET_GLOBAL.int(1973496+823+56+3, 100)
	SET_GLOBAL.int(1973496+823+56+4, 100)
	add_to_history("Admin", "Set Cayo Pericos Crews cut all to 100%", "Revamped Recovery")
	return
	end
	if message_text:lower():find("^!franklincooldown") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	if input ~= nil then
		if input == "on" then
			SET_GLOBAL.int(262145+31329, 0)
			SET_GLOBAL.int(262145+31407, 0)
			add_to_history("Admin", "Removed Security Contract & Payphone Hit Cooldown", "Revamped Recovery")
		elseif input == "off" then
			SET_GLOBAL.int(262145+31329, 300000)
			SET_GLOBAL.int(262145+31407, 1200000)
			add_to_history("Admin", "Reset Security Contract & Payphone Hit Cooldown to default", "Revamped Recovery")
		else
			add_to_history("Admin", "You must specify on or off example, !franklincooldown on", "Revamped Recovery")
		end
		else
			add_to_history("Admin", "You must specify on or off example, !franklincooldown on", "Revamped Recovery")
		end
	return
	end
	if message_text:lower():find("^!orbitalrefund") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	if input ~= nil then

		if input == "750k" then
			SET_GLOBAL.int(1964171, 2)
			add_to_history("Admin", "Refunded player 750k (Will not work again till 3 minutes passed)", "Revamped Recovery")
		elseif input == "500k" then
			SET_GLOBAL.int(1964171, 1)
		elseif input == "100k" then
			SET_GLOBAL.int(262145+22853, 100000)
			SET_GLOBAL.int(262145+22855, 100000)
			SET_GLOBAL.int(1964171, 1)
			SET_GLOBAL.int(262145+22853, 500000)
			SET_GLOBAL.int(262145+22855, 500000)
			add_to_history("Admin", "Refunded player 500k (Will not work again till 3 minutes passed)", "Revamped Recovery")
		else
			add_to_history("Admin", "You must specify 500k or 750k or 100k example, !orbital 100k", "Revamped Recovery")
		end
		else
			add_to_history("Admin", "You must specify 500k or 750k or 100k example, !orbital 750k", "Revamped Recovery")
		end
	return
	end
	if message_text:lower():find("^!orbitalcooldown") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	if input ~= nil then
		if input == "on" then
			SET_GLOBAL.int(262145+22852, 0)
			add_to_history("Admin", "Removed Orbital Cannon Cooldown. You may have to re enter your Facility. ", "Revamped Recovery")
		elseif input == "off" then
			SET_GLOBAL.int(262145+22852, 2880000)
			add_to_history("Admin", "Set Orbital Cannon Cooldown back to default. You may have to re enter your Facility.", "Revamped Recovery")
		else
			add_to_history("Admin", "You must specify on or off example, !orbitalcooldown on", "Revamped Recovery")
		end
		else
			add_to_history("Admin", "You must specify on or off example, !orbitalcooldown on", "Revamped Recovery")
		end
	return
	end
	if message_text:lower():find("^!missilecooldown") ~= nil then
	local input = string.match(message_text:lower(), " (.*)")
	if input ~= nil then
		if input == "on" then
			SET_GLOBAL.int(262145+29821, 0)
			add_to_history("Admin", "Removed Kosatka Sub Missile cooldown. You may have to re enter your Sub. ", "Revamped Recovery")
		elseif input == "off" then
			SET_GLOBAL.int(262145+29821, 60000)
			add_to_history("Admin", "Set Kosatka Sub Missile cooldown back to default. You may have to re enter your Sub.", "Revamped Recovery")
		else
			add_to_history("Admin", "You must specify on or off example, !missilecooldown on", "Revamped Recovery")
		end
		else
			add_to_history("Admin", "You must specify on or off example, !missilecooldown on", "Revamped Recovery")
		end
	return
	end
end