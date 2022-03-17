-- Portal --

--replaces AoD spell (change constant if you think it should cost differently, or have a different range. should only have 1 shot. should have 10k to 25k range(currently 24576). should  cost high (currently 799999 mana, which is volc mana -1, so the order in spells panel doesn't change))
--creates a 1 way portal that remains open for 12 seconds
--the entrance is always on the caster's CoR (rs). the destination is where the spell is cast (big range)
--only units/shaman of the caster's color may enter the portal

-- (it currently replaces angel of death, but can replace any spell. however, this would require some modding, replacing sounds, data files and scripting.)
-- !! to add this to your map, edit reincarnating Site(CoR) coordinates: lines 43-50 !!

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

include("UtilRefs.lua")
include("LibMap.lua")
--------------------------
import(Module_DataTypes)
_gsi = gsi()

function every2Pow(a)
  if (_gsi.Counts.GameTurn % 2^a == 0) then
    return true else return false
  end
end

local random1 = 0
--------------------------
--CoR locations (edit them)
local BlueCoR = MAP_XZ_2_WORLD_XYZ(92,86)
local RedCoR = MAP_XZ_2_WORLD_XYZ(172,158)
local YellowCoR = MAP_XZ_2_WORLD_XYZ(88,150)
local GreenCoR = MAP_XZ_2_WORLD_XYZ(160,96)
local CyanCoR = MAP_XZ_2_WORLD_XYZ(0,0)
local PinkCoR = MAP_XZ_2_WORLD_XYZ(0,0)
local BlackCoR = MAP_XZ_2_WORLD_XYZ(0,0)
local OrangeCoR = MAP_XZ_2_WORLD_XYZ(0,0)

local portalActiveB = 0
local PortalposB = 0
local portalTimerB = 0
--
local portalActiveR = 0
local PortalposR = 0
local portalTimerR = 0
--
local portalActiveY = 0
local PortalposY = 0
local portalTimerY = 0
--
local portalActiveG = 0
local PortalposG = 0
local portalTimerG = 0
--
local portalActiveC = 0
local PortalposC = 0
local portalTimerC = 0
--
local portalActiveP = 0
local PortalposP = 0
local portalTimerP = 0
--
local portalActiveN = 0
local PortalposN = 0
local portalTimerN = 0
--
local portalActiveO = 0
local PortalposO = 0
local portalTimerO = 0
--
local CoREffectB = 0
local CoREffectR = 0
local CoREffectY = 0
local CoREffectG = 0
local CoREffectC = 0
local CoREffectP = 0
local CoREffectN = 0
local CoREffectO = 0
--
--remove shots
function RemoveOneCharge(pn, model)
	local shots = GET_NUM_ONE_OFF_SPELLS(pn, model)
	if (shots > 0) then
		shots = shots - 1
	end
	_gsi.ThisLevelInfo.PlayerThings[pn].SpellsAvailableOnce[model] = _gsi.ThisLevelInfo.PlayerThings[pn].SpellsAvailableOnce[model] & 240
	_gsi.ThisLevelInfo.PlayerThings[pn].SpellsAvailableOnce[model] = _gsi.ThisLevelInfo.PlayerThings[pn].SpellsAvailableOnce[model] | shots
end

function OnTurn()

	--blue
	if (portalActiveB == 1) then
		if (every2Pow(2)) then
			createThing(T_EFFECT,59,TRIBE_NEUTRAL,PortalposB,false,false)
		end
		if (every2Pow(3)) then
			createThing(T_EFFECT,67,TRIBE_NEUTRAL,PortalposB,false,false)
		end
		if (every2Pow(4)) then
			createThing(T_EFFECT,73,TRIBE_BLUE,BlueCoR,false,false)--cv sparkles rs
			createThing(T_EFFECT,68,TRIBE_NEUTRAL,PortalposB,false,false)
		end
		--end of timer
		if (every2Pow(3)) then
			if (GetTurn() > portalTimerB) and (portalTimerB ~= 0) then
				portalTimerB = 0
				portalActiveB = 0
				DestroyThing(CoREffectB)
			end
		end
		--units entering
		local Bcor = Coord3D.new()
		Bcor = BlueCoR
		local count = 0
		SearchMapCells(CIRCULAR, 0, 0 , 2, world_coord3d_to_map_idx(Bcor), function(me)
			me.MapWhoList:processList(function (t)
				if (t.Type == T_PERSON) then
					if (t.Owner == 0) then --can all colors cross or only who casted it? currently owner only: change "== 0" with "< 8" for otherwise
						if (t.Model < 8) and (t.Model > 1) then
							count = count + 1
							queue_sound_event(nil,SND_EVENT_GHOST_DIE, SEF_FIXED_VARS)
							move_thing_within_mapwho(t, PortalposB)
							t.Pos.D3.Ypos = 380
						end
					end
				end
			return true
			end)
		return true
		end)
	end
	--red
	if (portalActiveR == 1) then
		if (every2Pow(2)) then
			createThing(T_EFFECT,59,TRIBE_NEUTRAL,PortalposR,false,false)
		end
		if (every2Pow(3)) then
			createThing(T_EFFECT,67,TRIBE_NEUTRAL,PortalposR,false,false)
		end
		if (every2Pow(4)) then
			createThing(T_EFFECT,73,TRIBE_RED,RedCoR,false,false)--cv sparkles rs
			createThing(T_EFFECT,68,TRIBE_NEUTRAL,PortalposR,false,false)
		end
		--end of timer
		if (every2Pow(3)) then
			if (GetTurn() > portalTimerR) and (portalTimerR ~= 0) then
				portalTimerR = 0
				portalActiveR = 0
				DestroyThing(CoREffectR)
			end
		end
		--units entering
		local Rcor = Coord3D.new()
		Rcor = RedCoR
		local countR = 0
		SearchMapCells(CIRCULAR, 0, 0 , 2, world_coord3d_to_map_idx(Rcor), function(me)
			me.MapWhoList:processList(function (t)
				if (t.Type == T_PERSON) then
					if (t.Owner == 1) then --can all colors cross or only who casted it? currently owner only: change "== 0" with "< 8" for otherwise
						if (t.Model < 8) and (t.Model > 1) then
							countR = countR + 1
							queue_sound_event(nil,SND_EVENT_GHOST_DIE, SEF_FIXED_VARS)
							move_thing_within_mapwho(t, PortalposR)
							t.Pos.D3.Ypos = 380
						end
					end
				end
			return true
			end)
		return true
		end)
	end
	--yellow
	if (portalActiveY == 1) then
		if (every2Pow(2)) then
			createThing(T_EFFECT,59,TRIBE_NEUTRAL,PortalposY,false,false)
		end
		if (every2Pow(3)) then
			createThing(T_EFFECT,67,TRIBE_NEUTRAL,PortalposY,false,false)
		end
		if (every2Pow(4)) then
			createThing(T_EFFECT,73,TRIBE_YELLOW,YellowCoR,false,false)--cv sparkles rs
			createThing(T_EFFECT,68,TRIBE_NEUTRAL,PortalposY,false,false)
		end
		--end of timer
		if (every2Pow(3)) then
			if (GetTurn() > portalTimerY) and (portalTimerY ~= 0) then
				portalTimerY = 0
				portalActiveY = 0
				DestroyThing(CoREffectY)
			end
		end
		--units entering
		local Ycor = Coord3D.new()
		Ycor = YellowCoR
		local countY = 0
		SearchMapCells(CIRCULAR, 0, 0 , 2, world_coord3d_to_map_idx(Ycor), function(me)
			me.MapWhoList:processList(function (t)
				if (t.Type == T_PERSON) then
					if (t.Owner == 2) then --can all colors cross or only who casted it? currently owner only: change "== 0" with "< 8" for otherwise
						if (t.Model < 8) and (t.Model > 1) then
							countY = countY + 1
							queue_sound_event(nil,SND_EVENT_GHOST_DIE, SEF_FIXED_VARS)
							move_thing_within_mapwho(t, PortalposY)
							t.Pos.D3.Ypos = 380
						end
					end
				end
			return true
			end)
		return true
		end)
	end
	--green
	if (portalActiveG == 1) then
		if (every2Pow(2)) then
			createThing(T_EFFECT,59,TRIBE_NEUTRAL,PortalposG,false,false)
		end
		if (every2Pow(3)) then
			createThing(T_EFFECT,67,TRIBE_NEUTRAL,PortalposG,false,false)
		end
		if (every2Pow(4)) then
			createThing(T_EFFECT,73,TRIBE_GREEN,GreenCoR,false,false)--cv sparkles rs
			createThing(T_EFFECT,68,TRIBE_NEUTRAL,PortalposG,false,false)
		end
		--end of timer
		if (every2Pow(3)) then
			if (GetTurn() > portalTimerG) and (portalTimerG ~= 0) then
				portalTimerG = 0
				portalActiveG = 0
				DestroyThing(CoREffectG)
			end
		end
		--units entering
		local Gcor = Coord3D.new()
		Gcor = GreenCoR
		local countG = 0
		SearchMapCells(CIRCULAR, 0, 0 , 2, world_coord3d_to_map_idx(Gcor), function(me)
			me.MapWhoList:processList(function (t)
				if (t.Type == T_PERSON) then
					if (t.Owner == 3) then --can all colors cross or only who casted it? currently owner only: change "== 0" with "< 8" for otherwise
						if (t.Model < 8) and (t.Model > 1) then
							countG = countG + 1
							queue_sound_event(nil,SND_EVENT_GHOST_DIE, SEF_FIXED_VARS)
							move_thing_within_mapwho(t, PortalposG)
							t.Pos.D3.Ypos = 380
						end
					end
				end
			return true
			end)
		return true
		end)
	end
	--cyan
	if (portalActiveC == 1) then
		if (every2Pow(2)) then
			createThing(T_EFFECT,59,TRIBE_NEUTRAL,PortalposC,false,false)
		end
		if (every2Pow(3)) then
			createThing(T_EFFECT,67,TRIBE_NEUTRAL,PortalposC,false,false)
		end
		if (every2Pow(4)) then
			createThing(T_EFFECT,73,TRIBE_CYAN,CyanCoR,false,false)--cv sparkles rs
			createThing(T_EFFECT,68,TRIBE_NEUTRAL,PortalposC,false,false)
		end
		--end of timer
		if (every2Pow(3)) then
			if (GetTurn() > portalTimerC) and (portalTimerC ~= 0) then
				portalTimerC = 0
				portalActiveC = 0
				DestroyThing(CoREffectC)
			end
		end
		--units entering
		local Ccor = Coord3D.new()
		Ccor = CyanCoR
		local countC = 0
		SearchMapCells(CIRCULAR, 0, 0 , 2, world_coord3d_to_map_idx(Ccor), function(me)
			me.MapWhoList:processList(function (t)
				if (t.Type == T_PERSON) then
					if (t.Owner == 4) then --can all colors cross or only who casted it? currently owner only: change "== 0" with "< 8" for otherwise
						if (t.Model < 8) and (t.Model > 1) then
							countC = countC + 1
							queue_sound_event(nil,SND_EVENT_GHOST_DIE, SEF_FIXED_VARS)
							move_thing_within_mapwho(t, PortalposC)
							t.Pos.D3.Ypos = 380
						end
					end
				end
			return true
			end)
		return true
		end)
	end
	--pink
	if (portalActiveP == 1) then
		if (every2Pow(2)) then
			createThing(T_EFFECT,59,TRIBE_NEUTRAL,PortalposP,false,false)
		end
		if (every2Pow(3)) then
			createThing(T_EFFECT,67,TRIBE_NEUTRAL,PortalposP,false,false)
		end
		if (every2Pow(4)) then
			createThing(T_EFFECT,73,TRIBE_PINK,PinkCoR,false,false)--cv sparkles rs
			createThing(T_EFFECT,68,TRIBE_NEUTRAL,PortalposP,false,false)
		end
		--end of timer
		if (every2Pow(3)) then
			if (GetTurn() > portalTimerP) and (portalTimerP ~= 0) then
				portalTimerP = 0
				portalActiveP = 0
				DestroyThing(CoREffectP)
			end
		end
		--units entering
		local Pcor = Coord3D.new()
		Pcor = PinkCoR
		local countP = 0
		SearchMapCells(CIRCULAR, 0, 0 , 2, world_coord3d_to_map_idx(Pcor), function(me)
			me.MapWhoList:processList(function (t)
				if (t.Type == T_PERSON) then
					if (t.Owner == 5) then --can all colors cross or only who casted it? currently owner only: change "== 0" with "< 8" for otherwise
						if (t.Model < 8) and (t.Model > 1) then
							countP = countP + 1
							queue_sound_event(nil,SND_EVENT_GHOST_DIE, SEF_FIXED_VARS)
							move_thing_within_mapwho(t, PortalposP)
							t.Pos.D3.Ypos = 380
						end
					end
				end
			return true
			end)
		return true
		end)
	end
	--black
	if (portalActiveN == 1) then
		if (every2Pow(2)) then
			createThing(T_EFFECT,59,TRIBE_NEUTRAL,PortalposN,false,false)
		end
		if (every2Pow(3)) then
			createThing(T_EFFECT,67,TRIBE_NEUTRAL,PortalposN,false,false)
		end
		if (every2Pow(4)) then
			createThing(T_EFFECT,73,TRIBE_BLACK,BlackCoR,false,false)--cv sparkles rs
			createThing(T_EFFECT,68,TRIBE_NEUTRAL,PortalposN,false,false)
		end
		--end of timer
		if (every2Pow(3)) then
			if (GetTurn() > portalTimerN) and (portalTimerN ~= 0) then
				portalTimerN = 0
				portalActiveN = 0
				DestroyThing(CoREffectN)
			end
		end
		--units entering
		local Ncor = Coord3D.new()
		Ncor = BlackCoR
		local countN = 0
		SearchMapCells(CIRCULAR, 0, 0 , 2, world_coord3d_to_map_idx(Ncor), function(me)
			me.MapWhoList:processList(function (t)
				if (t.Type == T_PERSON) then
					if (t.Owner == 6) then --can all colors cross or only who casted it? currently owner only: change "== 0" with "< 8" for otherwise
						if (t.Model < 8) and (t.Model > 1) then
							countN = countN + 1
							queue_sound_event(nil,SND_EVENT_GHOST_DIE, SEF_FIXED_VARS)
							move_thing_within_mapwho(t, PortalposN)
							t.Pos.D3.Ypos = 380
						end
					end
				end
			return true
			end)
		return true
		end)
	end
	--orange
	if (portalActiveO == 1) then
		if (every2Pow(2)) then
			createThing(T_EFFECT,59,TRIBE_NEUTRAL,PortalposO,false,false)
		end
		if (every2Pow(3)) then
			createThing(T_EFFECT,67,TRIBE_NEUTRAL,PortalposO,false,false)
		end
		if (every2Pow(4)) then
			createThing(T_EFFECT,73,TRIBE_ORANGE,OrangeCoR,false,false)--cv sparkles rs
			createThing(T_EFFECT,68,TRIBE_NEUTRAL,PortalposO,false,false)
		end
		--end of timer
		if (every2Pow(3)) then
			if (GetTurn() > portalTimerO) and (portalTimerO ~= 0) then
				portalTimerO = 0
				portalActiveO = 0
				DestroyThing(CoREffectO)
			end
		end
		--units entering
		local Ocor = Coord3D.new()
		Ocor = BlueCoR
		local countO = 0
		SearchMapCells(CIRCULAR, 0, 0 , 2, world_coord3d_to_map_idx(Ocor), function(me)
			me.MapWhoList:processList(function (t)
				if (t.Type == T_PERSON) then
					if (t.Owner == 7) then --can all colors cross or only who casted it? currently owner only: change "== 0" with "< 8" for otherwise
						if (t.Model < 8) and (t.Model > 1) then
							countO = countO + 1
							queue_sound_event(nil,SND_EVENT_GHOST_DIE, SEF_FIXED_VARS)
							move_thing_within_mapwho(t, PortalposO)
							t.Pos.D3.Ypos = 380
						end
					end
				end
			return true
			end)
		return true
		end)
	end
	
	
	
end --END OF ON TURN




function OnCreateThing(t)

	--blue
	if (t.Type == T_SPELL) then
		if (t.Model == M_SPELL_ANGEL_OF_DEATH) then
			local pos = world_coord3d_to_map_idx(t.Pos.D3)
			if (t.Owner == TRIBE_BLUE) then
				queue_sound_event(nil,SND_EVENT_DISCOBLDG_CIRC,SEF_FIXED_VARS)
				portalActiveB = 1
				t.Model = M_SPELL_NONE
				RemoveOneCharge(0, M_SPELL_ANGEL_OF_DEATH)
				PortalposB = (t.Pos.D3)
				portalTimerB = GetTurn() + 144 --12 seconds lasting portal
				createThing(T_EFFECT,M_EFFECT_PREPARE_RS_LAND ,TRIBE_NEUTRAL,(BlueCoR),false,false)
				centre_coord3d_on_block(BlueCoR)
				CoREffectB = createThing(T_SCENERY,M_SCENERY_TOP_LEVEL_SCENERY ,TRIBE_NEUTRAL,(BlueCoR),false,false)
				set_thing_draw_info(CoREffectB, TDI_OBJECT_GENERIC, 31) --book
				ensure_thing_on_ground(CoREffectB)
			end
		end
	end
	--red
	if (t.Type == T_SPELL) then
		if (t.Model == M_SPELL_ANGEL_OF_DEATH) then
			local pos = world_coord3d_to_map_idx(t.Pos.D3)
			if (t.Owner == TRIBE_RED) then
				queue_sound_event(nil,SND_EVENT_DISCOBLDG_CIRC,SEF_FIXED_VARS)
				portalActiveR = 1
				t.Model = M_SPELL_NONE
				RemoveOneCharge(1, M_SPELL_ANGEL_OF_DEATH)
				PortalposR = (t.Pos.D3)
				portalTimerR = GetTurn() + 144 --12 seconds lasting portal
				createThing(T_EFFECT,M_EFFECT_PREPARE_RS_LAND ,TRIBE_NEUTRAL,(RedCoR),false,false)
				centre_coord3d_on_block(RedCoR)
				CoREffectR = createThing(T_SCENERY,M_SCENERY_TOP_LEVEL_SCENERY ,TRIBE_NEUTRAL,(RedCoR),false,false)
				set_thing_draw_info(CoREffectR, TDI_OBJECT_GENERIC, 31) --book
				ensure_thing_on_ground(CoREffectR)
			end
		end
	end

	--yellow
	if (t.Type == T_SPELL) then
		if (t.Model == M_SPELL_ANGEL_OF_DEATH) then
			local pos = world_coord3d_to_map_idx(t.Pos.D3)
			if (t.Owner == TRIBE_YELLOW) then
				queue_sound_event(nil,SND_EVENT_DISCOBLDG_CIRC,SEF_FIXED_VARS)
				portalActiveY = 1
				t.Model = M_SPELL_NONE
				RemoveOneCharge(2, M_SPELL_ANGEL_OF_DEATH)
				PortalposY = (t.Pos.D3)
				portalTimerY = GetTurn() + 144 --12 seconds lasting portal
				createThing(T_EFFECT,M_EFFECT_PREPARE_RS_LAND ,TRIBE_NEUTRAL,(YellowCoR),false,false)
				centre_coord3d_on_block(YellowCoR)
				CoREffectY = createThing(T_SCENERY,M_SCENERY_TOP_LEVEL_SCENERY ,TRIBE_NEUTRAL,(YellowCoR),false,false)
				set_thing_draw_info(CoREffectY, TDI_OBJECT_GENERIC, 31) --book
				ensure_thing_on_ground(CoREffectY)
			end
		end
	end

	--green
	if (t.Type == T_SPELL) then
		if (t.Model == M_SPELL_ANGEL_OF_DEATH) then
			local pos = world_coord3d_to_map_idx(t.Pos.D3)
			if (t.Owner == TRIBE_GREEN) then
				queue_sound_event(nil,SND_EVENT_DISCOBLDG_CIRC,SEF_FIXED_VARS)
				portalActiveG = 1
				t.Model = M_SPELL_NONE
				RemoveOneCharge(3, M_SPELL_ANGEL_OF_DEATH)
				PortalposG = (t.Pos.D3)
				portalTimerG = GetTurn() + 144 --12 seconds lasting portal
				createThing(T_EFFECT,M_EFFECT_PREPARE_RS_LAND ,TRIBE_NEUTRAL,(GreenCoR),false,false)
				centre_coord3d_on_block(GreenCoR)
				CoREffectG = createThing(T_SCENERY,M_SCENERY_TOP_LEVEL_SCENERY ,TRIBE_NEUTRAL,(GreenCoR),false,false)
				set_thing_draw_info(CoREffectG, TDI_OBJECT_GENERIC, 31) --book
				ensure_thing_on_ground(CoREffectG)
			end
		end
	end

	--cyan
	if (t.Type == T_SPELL) then
		if (t.Model == M_SPELL_ANGEL_OF_DEATH) then
			local pos = world_coord3d_to_map_idx(t.Pos.D3)
			if (t.Owner == TRIBE_CYAN) then
				queue_sound_event(nil,SND_EVENT_DISCOBLDG_CIRC,SEF_FIXED_VARS)
				portalActiveC = 1
				t.Model = M_SPELL_NONE
				RemoveOneCharge(4, M_SPELL_ANGEL_OF_DEATH)
				PortalposC = (t.Pos.D3)
				portalTimerC = GetTurn() + 144 --12 seconds lasting portal
				createThing(T_EFFECT,M_EFFECT_PREPARE_RS_LAND ,TRIBE_NEUTRAL,(CyanCoR),false,false)
				centre_coord3d_on_block(CyanCor)
				CoREffectC = createThing(T_SCENERY,M_SCENERY_TOP_LEVEL_SCENERY ,TRIBE_NEUTRAL,(CyanCor),false,false)
				set_thing_draw_info(CoREffectC, TDI_OBJECT_GENERIC, 31) --book
				ensure_thing_on_ground(CoREffectC)
			end
		end
	end

	--pink
	if (t.Type == T_SPELL) then
		if (t.Model == M_SPELL_ANGEL_OF_DEATH) then
			local pos = world_coord3d_to_map_idx(t.Pos.D3)
			if (t.Owner == TRIBE_PINK) then
				queue_sound_event(nil,SND_EVENT_DISCOBLDG_CIRC,SEF_FIXED_VARS)
				portalActiveP = 1
				t.Model = M_SPELL_NONE
				RemoveOneCharge(5, M_SPELL_ANGEL_OF_DEATH)
				PortalposP = (t.Pos.D3)
				portalTimerP = GetTurn() + 144 --12 seconds lasting portal
				createThing(T_EFFECT,M_EFFECT_PREPARE_RS_LAND ,TRIBE_NEUTRAL,(PinkCoR),false,false)
				centre_coord3d_on_block(PinkCoR)
				CoREffectP = createThing(T_SCENERY,M_SCENERY_TOP_LEVEL_SCENERY ,TRIBE_NEUTRAL,(PinkCoR),false,false)
				set_thing_draw_info(CoREffectP, TDI_OBJECT_GENERIC, 31) --book
				ensure_thing_on_ground(CoREffectP)
			end
		end
	end

	--black
	if (t.Type == T_SPELL) then
		if (t.Model == M_SPELL_ANGEL_OF_DEATH) then
			local pos = world_coord3d_to_map_idx(t.Pos.D3)
			if (t.Owner == TRIBE_BLACK) then
				queue_sound_event(nil,SND_EVENT_DISCOBLDG_CIRC,SEF_FIXED_VARS)
				portalActiveN = 1
				t.Model = M_SPELL_NONE
				RemoveOneCharge(6, M_SPELL_ANGEL_OF_DEATH)
				PortalposN = (t.Pos.D3)
				portalTimerN = GetTurn() + 144 --12 seconds lasting portal
				createThing(T_EFFECT,M_EFFECT_PREPARE_RS_LAND ,TRIBE_NEUTRAL,(BlackCoR),false,false)
				centre_coord3d_on_block(BlackCoR)
				CoREffectN = createThing(T_SCENERY,M_SCENERY_TOP_LEVEL_SCENERY ,TRIBE_NEUTRAL,(BlackCoR),false,false)
				set_thing_draw_info(CoREffectN, TDI_OBJECT_GENERIC, 31) --book
				ensure_thing_on_ground(CoREffectN)
			end
		end
	end

	--orange
	if (t.Type == T_SPELL) then
		if (t.Model == M_SPELL_ANGEL_OF_DEATH) then
			local pos = world_coord3d_to_map_idx(t.Pos.D3)
			if (t.Owner == TRIBE_ORANGE) then
				queue_sound_event(nil,SND_EVENT_DISCOBLDG_CIRC,SEF_FIXED_VARS)
				portalActiveO = 1
				t.Model = M_SPELL_NONE
				RemoveOneCharge(7, M_SPELL_ANGEL_OF_DEATH)
				PortalposO = (t.Pos.D3)
				portalTimerO = GetTurn() + 144 --12 seconds lasting portal
				createThing(T_EFFECT,M_EFFECT_PREPARE_RS_LAND ,TRIBE_NEUTRAL,(OrangeCoR),false,false)
				centre_coord3d_on_block(OrangeCoR)
				CoREffectO = createThing(T_SCENERY,M_SCENERY_TOP_LEVEL_SCENERY ,TRIBE_NEUTRAL,(OrangeCoR),false,false)
				set_thing_draw_info(CoREffectO, TDI_OBJECT_GENERIC, 31) --book
				ensure_thing_on_ground(CoREffectO)
			end
		end
	end
end

-- By Divinity, March 2021 --