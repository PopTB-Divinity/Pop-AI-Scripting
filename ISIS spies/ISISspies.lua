-- ISIS spies --

-- spies blow up near enemy buildings and/or units
-- they blow up while "disguising" or "re-disguising"
-- step 1: disguise them
-- step 2: send them near enemy units/buildings
-- step 3: press the "disguise button" to blow the spy and everything around it, like a true ISIS suicide bomber

import(Module_Game)
import(Module_MapWho)
import(Module_Math)
import(Module_Objects)
import(Module_Person)
import(Module_Table)
import(Module_Sound)
import(Module_PopScript)
import(Module_Game)
import(Module_Defines)
import(Module_Globals)
import(Module_Level)
import(Module_Players)
import(Module_Map)
import(Module_Helpers)
import(Module_Draw)
import(Module_DataTypes)
include("UtilRefs.lua")
include("LibMap.lua")
--------------------------
local random1 = 0

function OnTurn()

	ProcessGlobalSpecialListAll(0, function(t)
		if (t.Model == M_PERSON_SPY) then
			SearchMapCells(1, 0, 0, 2, world_coord3d_to_map_idx(t.Pos.D3), function(me)
				me.MapWhoList:processList(function (h)
					if (h.Type == T_BUILDING) or (h.Type == T_PERSON) then
						if (h.Owner ~= t.Owner) and (h.Owner ~= TRIBE_NEUTRAL) and (h.Owner ~= TRIBE_HOSTBOT) then
							if (h.Model < 17) and (is_spy_in_process_of_disguising(t) == 1) then
								--spy dies and explodes+fire close buildings
								DestroyThing (t)
								queue_sound_event(nil,SND_EVENT_BLDG_EXPLODE  , SEF_FIXED_VARS)
								createThing(T_EFFECT,14,TRIBE_NEUTRAL,h.Pos.D3,false,false) --explode close bldgs
								createThing(T_EFFECT,28,TRIBE_NEUTRAL,h.Pos.D3,false,false) --burn close bldgs
								createThing(T_EFFECT,28,TRIBE_NEUTRAL,t.Pos.D3,false,false)
								createThing(T_EFFECT,28,TRIBE_NEUTRAL,t.Pos.D3,false,false)
								createThing(T_EFFECT,28,TRIBE_NEUTRAL,t.Pos.D3,false,false)
								createThing(T_EFFECT,64,TRIBE_NEUTRAL,t.Pos.D3,false,false) --firecloud effect on the spy
								--checks and explodes 1 wood of nearby huts (5 radius)
								SearchMapCells(1, 0, 2, 5, world_coord3d_to_map_idx(t.Pos.D3), function(me)
									me.MapWhoList:processList(function (y)
										if (y.Type == T_BUILDING) then
											if (y.Owner < 8) then
												createThing(T_EFFECT,14,TRIBE_NEUTRAL,y.Pos.D3,false,false) --explode distant bldgs (no burn)
											end
										end
									return true
									end)
								return true
								end)
							end
						end
					end
				return true
				end)
			return true
			end)
		end
	return true
	end)
	
end

-- By Divinity, March 2021