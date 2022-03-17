-- Regicide (spy is the king)

--[[

This is Populous - regicide mode. That means the level should have an initial spy for each tribe, that works as the "king". The players must play
the game normally, but pay attention and defend their spy - if it dies, they lose.

Don't add spy hut to the level, or play levels with armageddon or stones that give spies!

]]

import(Module_Defines)
import(Module_Map)
import(Module_Objects)
import(Module_DataTypes)
import(Module_Game)
import(Module_Table)
import(Module_MapWho)
import(Module_System)
import(Module_Globals)
import(Module_Players)
import(Module_PopScript)
import(Module_Math)
import(Module_String)
import(Module_ImGui)
import(Module_Draw)
import(Module_Person)
import(Module_Package)
import(Module_GameStates)
import(Module_StringTools)
import(Module_Helpers)
import(Module_Sound)
local gs = gsi()
local gns = gnsi()
_gnsi = gnsi()
_gsi = gsi()

function every2Pow(a)
  if (_gsi.Counts.GameTurn % 2^a == 0) then
    return true else return false
  end
end

pl = {[0] = 0,0,0,0,0,0,0,0}
for i = 0,7 do
	if _gsi.Players[i].NumPeople == 0 then
		pl[i] = -1
	end
end

function OnTurn()
	if (every2Pow(5)) then
		for i = 0,7 do
			if PLAYERS_PEOPLE_OF_TYPE(i, M_PERSON_SPY) == 0 and pl[i] == 0 then
				pl[i] = 1
				ProcessGlobalSpecialList(i,BUILDINGLIST, function(b)
					if b.Model < 4 and b ~= nil then
						b.State = 1
					end
				return true end)
				ProcessGlobalSpecialList(i, 0, function(t)
					if (t.Type == T_PERSON) and t ~= nil then
						damage_person(t,8,9999,1)
					end
				return true end)
				queue_sound_event(nil,SND_EVENT_SHAMAN_DIE,SEF_FIXED_VARS)
				log_msg(8,"" .. get_player_name(i, true) .. "'s spy has been assassinated.")
				if (gns.PlayerNum == i) then
					gns.Flags = gns.Flags | GNS_LEVEL_FAILED
				end
				SET_NO_REINC(i)
			end
		end
	end
end