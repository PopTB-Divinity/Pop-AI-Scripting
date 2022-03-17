--Shaman diamond sparkles (aesthetics only)

--[[

if shaman is alive, they have this cool diamond sparkles over them
the sparkles are of the tribe's color (as long as texture is beta compatible, else the 4 beta tribes will have a black sparkle)

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
import(Module_Draw)

local gns = gnsi()
local gs = gsi()
_gnsi = gnsi()
_gsi = gsi()

function every2Pow(a)
  if (_gsi.Counts.GameTurn % 2^a == 0) then
    return true else return false
  end
end

local colors = {[0]=2,-2,3,1,10,11,7,9}


function OnTurn()
	if every2Pow(1) then
		for i = 0,7 do
			if (getShaman(i) ~= nil) then
				local t = createThing(T_EFFECT,61,8,getShaman(i).Pos.D3,false,false)
				t.DrawInfo.Alpha = colors[i]
			end
		end
	end
end