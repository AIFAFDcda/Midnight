require("lib/natives")

function mpx()
	return "mp" .. script_global:new(1574915):get_int64() .. "_"
end

function add_to_history(player, message, scope)
	system.fiber(function(callback)
		local chat_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("multiplayer_chat")
		GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(chat_scaleform, 255, 255, 255, 255)
		GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(chat_scaleform, "ADD_MESSAGE")
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(player)
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(message)
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(scope)
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
	end)
end

function OnChatMsg(pid, message_text)
	system.fiber(function(callback) if pid ~=  PLAYER.PLAYER_ID() then return end end)

	if message_text:lower():find("^!setorgname") ~= nil then
		local input = string.match(message_text:lower(), " (.*)")
		system.fiber(function(callback)
			if input ~= nil then
				if string.len(input) > 32 then
					STATS.STAT_SET_STRING(string.smart_joaat(mpx() .. "gb_gang_name"), string.sub(input, 1, 32), true)
					STATS.STAT_SET_STRING(string.smart_joaat(mpx() .. "gb_gang_name2"), string.sub(input, 32, 64), true)
				else 
					STATS.STAT_SET_STRING(string.smart_joaat(mpx() .. "gb_gang_name"), input, true)
					STATS.STAT_SET_STRING(string.smart_joaat(mpx() .. "gb_gang_name2"), "", true)
				end	
				add_to_history("Admin", "Ceo name has been set", "INFO")
			else
				add_to_history("Admin", "You must specify name Example, !setorgname CEO NAME", "INFO")
			end
		end)
	return
	end
	if message_text:lower():find("^!setmcname") ~= nil then
		local input = string.match(message_text:lower(), " (.*)")
		system.fiber(function(callback)
			if input ~= nil then
				if string.len(input) > 32 then
					STATS.STAT_SET_STRING(string.smart_joaat(mpx() .. "mc_gang_name"), string.sub(input, 1, 32), true)
					STATS.STAT_SET_STRING(string.smart_joaat(mpx() .. "mc_gang_name2"), string.sub(input, 32, 64), true)
				else
					STATS.STAT_SET_STRING(string.smart_joaat(mpx() .. "mc_gang_name"), input, true)
					STATS.STAT_SET_STRING(string.smart_joaat(mpx() .. "mc_gang_name2"), "", true)
				end	
				add_to_history("Admin", "MC name has been set", "INFO")
			else
				add_to_history("Admin", "You must specify name Example, !setmcname This is a long name with a wanted star", "INFO")
			end
		end)
	return
	end
	return
end
