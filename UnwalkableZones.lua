-- UNWALKABLE ZONES --

--creates unwalkable zones on the map. 
--units can not walk in there. they can't even be blasted over (works like a wall). they can be tornado'd over, though...building plans can be set, but buildings will never be built.
--once the marker cell sinks (and becomes water), the zone becomes "walkable" again (so boats and balloons can go over it, and even blasted units). This feature can also be removed, if you want unwalkable zones permanent (whether it is water or land), so that even boats/balloons can't pass in case the zone becomes water. remove all the lines that have "--" after them to do so (line 40, and lines 43-47)

---------------------------------------------------------------------------------------------------------------------------------------------------------
import(Module_Defines)
import(Module_Map)
import(Module_Objects)
import(Module_DataTypes)
import(Module_PopScript)
import(Module_Game)
import(Module_Helpers)

function EnableFlag(_f1, _f2)
    if (_f1 & _f2 == 0) then
        _f1 = _f1 | _f2
    end
    return _f1
end
function DisableFlag(_f1, _f2)
    if (_f1 & _f2 == _f2) then
        _f1 = _f1 ~ _f2
    end
    return _f1
end
---------------------------------------------------------------------------------------------------------------------------------------------------------


unwalkableZones = {12,13,15,3,2,20,21} --here's the markers where it will be unwalkable (EDIT THIS)!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--(it's unwalkable (if land), and walkable again (if it turns water). (keeps updating, depending if land or water)


function OnTurn()

	for i,KEY in ipairs(unwalkableZones) do
		local mk2c3d = marker_to_coord3d(KEY)
		SearchMapCells(SQUARE, 0, 0 , 0, world_coord3d_to_map_idx(mk2c3d), function(me)
			if (is_map_elem_all_land(me) == 1)then --
				me.Flags = EnableFlag(me.Flags, (1<<2))
				me.Flags = EnableFlag(me.Flags, (1<<19))
			end --
			if (is_map_elem_all_sea(me) == 2) then	--
				me.Flags = DisableFlag(me.Flags, (1<<2)) --
				me.Flags = DisableFlag(me.Flags, (1<<10)) --
			end --
		return true
		end)
	end
	
	
end


-- By Divinity, May 2021

