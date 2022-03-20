-- SNOWING --


--(can change snow intensity (line 56), and how late the snow starts falling in the level (line 71))
--(must not be used in levels with swamp)

import(Module_Objects)
import(Module_Globals)
import(Module_DataTypes)
import(Module_Game)
import(Module_Map)
import(Module_Defines)
import(Module_Table)
import(Module_MapWho)
import(Module_System)
import(Module_Globals)
import(Module_Package)
import(Module_GameStates)
local gs = gsi()
local gns = gnsi()
local snow = {}
local snowing = 0
local count = 11
include("UtilPThings.lua")
include("UtilRefs.lua")

-----------------------------------------------------------

function process_snow()

	if (snowing == 1) then
		for k,v in pairs(snow) do
			if (v.Pos.D3.Ypos > 31) then
				v.Pos.D3.Ypos = v.Pos.D3.Ypos - 30;
			elseif (v.Pos.D3.Ypos <= 30) then
				v.Pos.D3.Ypos = v.Pos.D3.Ypos + 1785;
				--DestroyThing(v)
			end
		end
	end
	
end

function OnTurn()

	if (snowing == 1) then
		process_snow() --processes snow falling
	else
		--nothing
	end

-------------------------------------------------
	if (snowing == 1) then
		if (gs.Counts.GameTurn % 7 == 0) then
		    if (count > 0) then
				count = count - 1
				for i = 0, G_RANDOM(150) do --amount of snow (intensity)
					local c3d = Coord3D.new()
					c3d.Xpos = G_RANDOM (65500)
					c3d.Zpos = G_RANDOM (65500)
					local t_thing = createThing(T_EFFECT, 84, TRIBE_HOSTBOT, c3d, false, false) --create snow
					t_thing.Pos.D3.Ypos = t_thing.Pos.D3.Ypos + 1800 --altitude start
					table.insert(snow, t_thing)
				end	
			end
		end
	end
	
	
	if every2Pow(3) then
		if (gs.Counts.ProcessThings >= 13 and --start the snow gameturn (can be later in the level). 12 = 1 second | 720 = 1 minute...etc
			snowing == 0) then
			snowing = 1 
		end
	end
	
	
	
end
