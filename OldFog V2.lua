-- 1.03 fog in beta
--(fps intensive for games with high population. Only recommended for special modes/mini games)

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
_gsi = gsi()
function every2Pow(a)
  if (_gsi.Counts.GameTurn % 2^a == 0) then
    return true else return false
  end
end


function OnTurn()
	if every2Pow(5) then
		for i = 0,7 do
			ProcessGlobalSpecialList(i,PEOPLELIST, function(t)
				createThing(T_EFFECT,M_EFFECT_REVEAL_FOG_AREA ,i,t.Pos.D3,false,false)
			return true end)
		end
	end
end