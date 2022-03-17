-- EPICO SPECTATOR TOOL (press "1-8" to check the playing tribes (1 being blue, 8 being orange); press "tab" to not show
-- each player has 2 pages (eg.: press 1 to see first page of blue stats, press 1 again while on it to check next page of blue stats)
--(keys can be personalized a bit below, at lines 29+)
--only watchers or people that are not playing the game can access this, to avoid cheating (doesnt work as SPECTATOR only WATCHER, until inca adds support)

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
import(Module_Sound)
import(Module_Helpers)
---------------------------------------------------------------------CUSTOM KEYS HERE
--(refer to the keyboard codes here: http://www.populous3.info/script3_doc/_pop3_keys_8h_source.html . Don't use mouse "keys", they don't work.)
local KeyToNotDisplayInfo = LB_KEY_TAB
local KeyToSeeBlueInfo = LB_KEY_1
local KeyToSeeRedInfo = LB_KEY_2
local KeyToSeeYellowInfo = LB_KEY_3
local KeyToSeeGreenInfo = LB_KEY_4
local KeyToSeeCyanInfo = LB_KEY_5
local KeyToSeePinkInfo = LB_KEY_6
local KeyToSeeBlackInfo = LB_KEY_7
local KeyToSeeOrangeInfo = LB_KEY_8
--(the key to change the tool's HUD background is F12)
---------------------------------------------------------------------
---------------------------------------------------------------------
local gns = gnsi()
local gs = gsi()
_gnsi = gnsi()
_gsi = gsi()
--------------------------------------------
function every2Pow(a)
  if (_gsi.Counts.GameTurn % 2^a == 0) then
    return true else return false
  end
end

pl = {
			[0] =
			{
				GUIborder = 94,
				watching = -1,
				page = 0,
				shSpriteBase = 6879, --static
				shSprite = 6879, --changing
				shSprite2 = 7121,
				spellsCast = 0,
				color = 4,
				peopleKilled = 0,
				shDeaths = 0,
				shDeathsLock = 0,
				camper = 0,
				chargingSWARM = 0,
				chargingGHOST = 0,
				chargingLB = 0,
				chargingLIGHT = 0,
				chargingTORNADO = 0,
				chargingFLATTEN = 0,
				chargingEQ = 0,
				chargingFS = 0,
				chargingVOLC = 0,
				chargingSWARM2 = 0,
				chargingGHOST2 = 0,
				chargingLB2 = 0,
				chargingLIGHT2 = 0,
				chargingTORNADO2 = 0,
				chargingFLATTEN2 = 0,
				chargingEQ2 = 0,
				chargingFS2 = 0,
				chargingVOLC2 = 0
			},
			{
				GUIborder = 94,
				watching = -1,
				page = 0,
				shSpriteBase = 6899, --static
				shSprite = 6899, --changing
				shSprite2 = 7190,
				spellsCast = 0,
				color = 12,
				peopleKilled = 0,
				shDeaths = 0,
				shDeathsLock = 0,
				camper = 0,
				chargingSWARM = 0,
				chargingGHOST = 0,
				chargingLB = 0,
				chargingLIGHT = 0,
				chargingTORNADO = 0,
				chargingFLATTEN = 0,
				chargingEQ = 0,
				chargingFS = 0,
				chargingVOLC = 0,
				chargingSWARM2 = 0,
				chargingGHOST2 = 0,
				chargingLB2 = 0,
				chargingLIGHT2 = 0,
				chargingTORNADO2 = 0,
				chargingFLATTEN2 = 0,
				chargingEQ2 = 0,
				chargingFS2 = 0,
				chargingVOLC2 = 0
			},
			{
				GUIborder = 94,
				watching = -1,
				page = 0,
				shSpriteBase = 6919, --static
				shSprite = 6919, --changing
				shSprite2 = 7260,
				spellsCast = 0,
				color = 5,
				peopleKilled = 0,
				shDeaths = 0,
				shDeathsLock = 0,
				camper = 0,
				chargingSWARM = 0,
				chargingGHOST = 0,
				chargingLB = 0,
				chargingLIGHT = 0,
				chargingTORNADO = 0,
				chargingFLATTEN = 0,
				chargingEQ = 0,
				chargingFS = 0,
				chargingVOLC = 0,
				chargingSWARM2 = 0,
				chargingGHOST2 = 0,
				chargingLB2 = 0,
				chargingLIGHT2 = 0,
				chargingTORNADO2 = 0,
				chargingFLATTEN2 = 0,
				chargingEQ2 = 0,
				chargingFS2 = 0,
				chargingVOLC2 = 0
			},
			{
				GUIborder = 94,
				watching = -1,
				page = 0,
				shSpriteBase = 6939, --static
				shSprite = 6939, --changing
				shSprite2 = 7330,
				spellsCast = 0,
				color = 3,
				peopleKilled = 0,
				shDeaths = 0,
				shDeathsLock = 0,
				camper = 0,
				chargingSWARM = 0,
				chargingGHOST = 0,
				chargingLB = 0,
				chargingLIGHT = 0,
				chargingTORNADO = 0,
				chargingFLATTEN = 0,
				chargingEQ = 0,
				chargingFS = 0,
				chargingVOLC = 0,
				chargingSWARM2 = 0,
				chargingGHOST2 = 0,
				chargingLB2 = 0,
				chargingLIGHT2 = 0,
				chargingTORNADO2 = 0,
				chargingFLATTEN2 = 0,
				chargingEQ2 = 0,
				chargingFS2 = 0,
				chargingVOLC2 = 0
			},
			{
				GUIborder = 94,									--CYAN
				watching = -1,
				page = 0,
				shSpriteBase = 6879, --static
				shSprite = 6879, --changing
				shSprite2 = 7121,
				spellsCast = 0,
				color = 7,
				peopleKilled = 0,
				shDeaths = 0,
				shDeathsLock = 0,
				camper = 0,
				chargingSWARM = 0,
				chargingGHOST = 0,
				chargingLB = 0,
				chargingLIGHT = 0,
				chargingTORNADO = 0,
				chargingFLATTEN = 0,
				chargingEQ = 0,
				chargingFS = 0,
				chargingVOLC = 0,
				chargingSWARM2 = 0,
				chargingGHOST2 = 0,
				chargingLB2 = 0,
				chargingLIGHT2 = 0,
				chargingTORNADO2 = 0,
				chargingFLATTEN2 = 0,
				chargingEQ2 = 0,
				chargingFS2 = 0,
				chargingVOLC2 = 0
			},
			{
				GUIborder = 94,
				watching = -1,
				page = 0,
				shSpriteBase = 6899, --static
				shSprite = 6899, --changing
				shSprite2 = 7190,
				spellsCast = 0,
				color = 6,
				peopleKilled = 0,
				shDeaths = 0,
				shDeathsLock = 0,
				camper = 0,
				chargingSWARM = 0,
				chargingGHOST = 0,
				chargingLB = 0,
				chargingLIGHT = 0,
				chargingTORNADO = 0,
				chargingFLATTEN = 0,
				chargingEQ = 0,
				chargingFS = 0,
				chargingVOLC = 0,
				chargingSWARM2 = 0,
				chargingGHOST2 = 0,
				chargingLB2 = 0,
				chargingLIGHT2 = 0,
				chargingTORNADO2 = 0,
				chargingFLATTEN2 = 0,
				chargingEQ2 = 0,
				chargingFS2 = 0,
				chargingVOLC2 = 0
			},
			{
				GUIborder = 94,
				watching = -1,
				page = 0,
				shSpriteBase = 6919, --static
				shSprite = 6919, --changing
				shSprite2 = 7260,
				spellsCast = 0,
				color = 1,
				peopleKilled = 0,
				shDeaths = 0,
				shDeathsLock = 0,
				camper = 0,
				chargingSWARM = 0,
				chargingGHOST = 0,
				chargingLB = 0,
				chargingLIGHT = 0,
				chargingTORNADO = 0,
				chargingFLATTEN = 0,
				chargingEQ = 0,
				chargingFS = 0,
				chargingVOLC = 0,
				chargingSWARM2 = 0,
				chargingGHOST2 = 0,
				chargingLB2 = 0,
				chargingLIGHT2 = 0,
				chargingTORNADO2 = 0,
				chargingFLATTEN2 = 0,
				chargingEQ2 = 0,
				chargingFS2 = 0,
				chargingVOLC2 = 0
			},
			{
				GUIborder = 94,
				watching = -1,
				page = 0,
				shSpriteBase = 6939, --static
				shSprite = 6939, --changing
				shSprite2 = 7330,
				spellsCast = 0,
				color = 14,
				peopleKilled = 0,
				shDeaths = 0,
				shDeathsLock = 0,
				camper = 0,
				chargingSWARM = 0,
				chargingGHOST = 0,
				chargingLB = 0,
				chargingLIGHT = 0,
				chargingTORNADO = 0,
				chargingFLATTEN = 0,
				chargingEQ = 0,
				chargingFS = 0,
				chargingVOLC = 0,
				chargingSWARM2 = 0,
				chargingGHOST2 = 0,
				chargingLB2 = 0,
				chargingLIGHT2 = 0,
				chargingTORNADO2 = 0,
				chargingFLATTEN2 = 0,
				chargingEQ2 = 0,
				chargingFS2 = 0,
				chargingVOLC2 = 0
			}
}
--------------------------------------------
function math.percent(percent,maxvalue)
    if tonumber(percent) and tonumber(maxvalue) then
        return (maxvalue*percent)/100
    end
    return false
end
--------------------------------------------


function OnTurn()
	if every2Pow(2) then
		--shaman icon draw changing (upon death)
		for i = 0,7 do
			for w = 0,7 do
				if i ~= w then
					if pl[i].watching == w then
						if getShaman(i) ~= nil then
							if pl[i].shSprite < pl[i].shSprite+3 then
								pl[i].shSprite = pl[i].shSprite + 1
							else
								pl[i].shSprite = pl[i].shSpriteBase
							end
						else
							local deadSprite = 7815
							if i == 1 or i == 5 then deadSprite = 7845
							elseif i == 2 or i == 6 then deadSprite = 7875
							elseif i == 3 or i == 7 then deadSprite = 7905 end
							pl[i].shSprite = deadSprite
						end
					end
				end
			end
		end
	end
	
	if (every2Pow(3)) then
		--own shaman deaths updating
		for i = 0,7 do
			if pl[i].shDeathsLock == 1 then
				if getShaman(i) ~= nil then
					pl[i].shDeathsLock = 0
				end
			else
				if getShaman(i) == nil then
					pl[i].shDeathsLock = 1
					pl[i].shDeaths = pl[i].shDeaths + 1
				end
			end
		end
	end
	
	if (every2Pow(4)) then
		--camping meter
		for i = 0,7 do
			if (_gsi.Players[i].NumPeople > 0) and (getShaman(i) ~= nil) then
				ProcessGlobalSpecialList(i,PEOPLELIST, function(c)
					if (c.Model == M_PERSON_MEDICINE_MAN) then
						SearchMapCells(1, 0, 0, 0, world_coord3d_to_map_idx(c.Pos.D3), function(me)
							me.MapWhoList:processList(function (t)
								if (t.Type == T_BUILDING) and (t.Owner == i) and (t.Model == 4) then
									if (are_coords_on_same_map_cell (c.Pos.D2,t.Pos.D2) ~= nil) then
										pl[i].camper = pl[i].camper + 1
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
		end
																			
		--CHARGING SPELLS FOR BAR
		for i = 0,7 do
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_INSECT_PLAGUE]
			if (curr <= pl[i].chargingSWARM2) or (curr == 0) then
				pl[i].chargingSWARM = 0
			elseif (curr > pl[i].chargingSWARM2) then
				pl[i].chargingSWARM = 1
			end
			pl[i].chargingSWARM2 = curr
			--
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_GHOST_ARMY]
			if (curr <= pl[i].chargingGHOST2) or (curr == 0) then
				pl[i].chargingGHOST = 0
			elseif (curr > pl[i].chargingGHOST2) then
				pl[i].chargingGHOST = 1
			end
			pl[i].chargingGHOST2 = curr
			--
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_LAND_BRIDGE]
			if (curr <= pl[i].chargingLB2) or (curr == 0) then
				pl[i].chargingLB = 0
			elseif (curr > pl[i].chargingLB2) then
				pl[i].chargingLB = 1
			end
			pl[i].chargingLB2 = curr
			--
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_LIGHTNING_BOLT]
			if (curr <= pl[i].chargingLIGHT2) or (curr == 0) then
				pl[i].chargingLIGHT = 0
			elseif (curr > pl[i].chargingLIGHT2) then
				pl[i].chargingLIGHT = 1
			end
			pl[i].chargingLIGHT2 = curr
			--
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_WHIRLWIND]
			if (curr <= pl[i].chargingTORNADO2) or (curr == 0) then
				pl[i].chargingTORNADO = 0
			elseif (curr > pl[i].chargingTORNADO2) then
				pl[i].chargingTORNADO = 1
			end
			pl[i].chargingTORNADO2 = curr
			--
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_FLATTEN]
			if (curr <= pl[i].chargingFLATTEN2) or (curr == 0) then
				pl[i].chargingFLATTEN = 0
			elseif (curr > pl[i].chargingFLATTEN2) then
				pl[i].chargingFLATTEN = 1
			end
			pl[i].chargingFLATTEN2 = curr
			--
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_EARTHQUAKE]
			if (curr <= pl[i].chargingEQ2) or (curr == 0) then
				pl[i].chargingEQ = 0
			elseif (curr > pl[i].chargingEQ2) then
				pl[i].chargingEQ = 1
			end
			pl[i].chargingEQ2 = curr
			--
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_FIRESTORM]
			if (curr <= pl[i].chargingFS2) or (curr == 0) then
				pl[i].chargingFS = 0
			elseif (curr > pl[i].chargingFS2) then
				pl[i].chargingFS = 1
			end
			pl[i].chargingFS2 = curr
			--
			local curr = _gsi.Players[i].SpellsMana[M_SPELL_VOLCANO]
			if (curr <= pl[i].chargingVOLC2) or (curr == 0) then
				pl[i].chargingVOLC = 0
			elseif (curr > pl[i].chargingVOLC2) then
				pl[i].chargingVOLC = 1
			end
			pl[i].chargingVOLC2 = curr
		end
		
		--enemy pop killed
		for i = 0,7 do
			pl[i].peopleKilled = _gsi.Players[i].PeopleKilled[1] + _gsi.Players[i].PeopleKilled[2] + _gsi.Players[i].PeopleKilled[3] +
								_gsi.Players[i].PeopleKilled[4] + _gsi.Players[i].PeopleKilled[5] + _gsi.Players[i].PeopleKilled[6] + _gsi.Players[i].PeopleKilled[7]
		end	  
	end
	
	if every2Pow(5) then
		--reset shaman sprites if needed
		for i = 0,7 do
			if getShaman(i) ~= nil then
				if (pl[i].shSprite > pl[i].shSpriteBase + 3) or (pl[i].shSprite < pl[i].shSpriteBase) then
					pl[i].shSprite = pl[i].shSpriteBase
				end
			end
		end
	end
end



function OnCreateThing(t)
	if t.Type == T_SPELL then
		pl[t.Owner].spellsCast = pl[t.Owner].spellsCast + 1
	end
end



function OnKeyDown(k)
	--HUD backgrounds (4)
	if (k == LB_KEY_F12) then
		local i = _gnsi.PlayerNum
		if _gsi.Players[i].NumPeople == 0 then
			if pl[i].GUIborder == 94 then
				pl[i].GUIborder = 95
			elseif pl[i].GUIborder == 95 then
				pl[i].GUIborder = 700
			elseif pl[i].GUIborder == 700 then
				pl[i].GUIborder = 706
			else
				pl[i].GUIborder = 94
			end
		end
	end

	--closing pages
	if k == KeyToNotDisplayInfo then
		local i = _gnsi.PlayerNum
		if _gsi.Players[i].NumPeople == 0 then
			pl[i].page = 0
			pl[i].watching = -1
		end
	end
	
	--opening pages
	if k == KeyToSeeBlueInfo then
		local i = _gnsi.PlayerNum
		if i ~= 0 and _gsi.Players[i].NumPeople == 0 then
			if pl[i].page == 0 then
				pl[i].page = 1
			else
				if pl[i].watching == 0 then
					if pl[i].page == 1 then
						pl[i].page = 2
					else
						pl[i].page = 1
					end
				end
			end
			pl[i].watching = 0
		end
	elseif k == KeyToSeeRedInfo then
		local i = _gnsi.PlayerNum
		if i ~= 1 and _gsi.Players[i].NumPeople == 0 then
			if pl[i].page == 0 then
				pl[i].page = 1
			else
				if pl[i].watching == 1 then
					if pl[i].page == 1 then
						pl[i].page = 2
					else
						pl[i].page = 1
					end
				end
			end
			pl[i].watching = 1
		end
	elseif k == KeyToSeeYellowInfo then
		local i = _gnsi.PlayerNum
		if i ~= 2 and _gsi.Players[i].NumPeople == 0 then
			if pl[i].page == 0 then
				pl[i].page = 1
			else
				if pl[i].watching == 2 then
					if pl[i].page == 1 then
						pl[i].page = 2
					else
						pl[i].page = 1
					end
				end
			end
			pl[i].watching = 2
		end
	elseif k == KeyToSeeGreenInfo then
		local i = _gnsi.PlayerNum
		if i ~= 3 and _gsi.Players[i].NumPeople == 0 then
			if pl[i].page == 0 then
				pl[i].page = 1
			else
				if pl[i].watching == 3 then
					if pl[i].page == 1 then
						pl[i].page = 2
					else
						pl[i].page = 1
					end
				end
			end
			pl[i].watching = 3
		end
	elseif k == KeyToSeeCyanInfo then
		local i = _gnsi.PlayerNum
		if i ~= 4 and _gsi.Players[i].NumPeople == 0 then
			if pl[i].page == 0 then
				pl[i].page = 1
			else
				if pl[i].watching == 4 then
					if pl[i].page == 1 then
						pl[i].page = 2
					else
						pl[i].page = 1
					end
				end
			end
			pl[i].watching = 4
		end
	elseif k == KeyToSeePinkInfo then
		local i = _gnsi.PlayerNum
		if i ~= 5 and _gsi.Players[i].NumPeople == 0 then
			if pl[i].page == 0 then
				pl[i].page = 1
			else
				if pl[i].watching == 5 then
					if pl[i].page == 1 then
						pl[i].page = 2
					else
						pl[i].page = 1
					end
				end
			end
			pl[i].watching = 5
		end
	elseif k == KeyToSeeBlackInfo then
		local i = _gnsi.PlayerNum
		if i ~= 6 and _gsi.Players[i].NumPeople == 0 then
			if pl[i].page == 0 then
				pl[i].page = 1
			else
				if pl[i].watching == 6 then
					if pl[i].page == 1 then
						pl[i].page = 2
					else
						pl[i].page = 1
					end
				end
			end
			pl[i].watching = 6
		end
	elseif k == KeyToSeeOrangeInfo then
		local i = _gnsi.PlayerNum
		if i ~= 7 and _gsi.Players[i].NumPeople == 0 then
			if pl[i].page == 0 then
				pl[i].page = 1
			else
				if pl[i].watching == 7 then
					if pl[i].page == 1 then
						pl[i].page = 2
					else
						pl[i].page = 1
					end
				end
			end
			pl[i].watching = 7
		end
	end
end



function OnFrame()
	for watcher = 0,7 do
		if watcher == _gnsi.PlayerNum then
			for i = 0,7 do
				if i ~= watcher and pl[watcher].watching == i then
					local w = ScreenWidth()
					local h = ScreenHeight()
					local guiW = GFGetGuiWidth()
					local cima = math.floor((h/5)+(h/36)+(h/30)+(h/36))
					local idealspritesize = math.floor(math.floor(h-(h/5+16+16+6))/34)
					local bank = 1 if i > 3 then bank = 2 end
					PopSetFont(1)
					LbDraw_ScaledSprite(-2,math.floor((h/6)-1),get_sprite(0,pl[watcher].GUIborder), guiW, math.floor((h-(h/6))+2))--new
					DrawBox(math.floor(w/88),math.floor((h/5)+16), math.floor(guiW-((w/88)*2)), math.floor(h-(h/5+16+16+6)),1)--new
					--PAGE 1
					if pl[watcher].page == 1 then
						if getShaman(i) ~= nil then
							LbDraw_ScaledSprite(math.floor(guiW/2)-math.floor(guiW/12),math.floor((h/5)+(h/36)),get_sprite(bank,pl[i].shSprite),math.floor(h/30),math.floor(h/30))-- shaman sprite alive
						else
							LbDraw_ScaledSprite(math.floor(guiW/2)-math.floor(guiW/12),math.floor((h/5)+(h/36)),get_sprite(bank,pl[i].shSprite),math.floor(h/30),math.floor(h/30))-- shaman sprite dead
						end
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*0+idealspritesize*0),get_sprite(0,681),idealspritesize,idealspritesize)-- total pop
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*1+idealspritesize*1),get_sprite(0,75),idealspritesize,idealspritesize)-- units
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*2+idealspritesize*2),get_sprite(0,76),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*3+idealspritesize*3),get_sprite(0,79),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*4+idealspritesize*4),get_sprite(0,77),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*5+idealspritesize*5),get_sprite(0,450),idealspritesize,idealspritesize)-- huts built
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*6+idealspritesize*6),get_sprite(0,120),idealspritesize,idealspritesize)-- towers built
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*7+idealspritesize*7),get_sprite(0,1065),idealspritesize,idealspritesize)-- spells
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*8+idealspritesize*8),get_sprite(0,1061),idealspritesize,idealspritesize)--
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*9+idealspritesize*9),get_sprite(0,1068),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*10+idealspritesize*10),get_sprite(0,1059),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*11+idealspritesize*11),get_sprite(0,1060),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*12+idealspritesize*12),get_sprite(0,1071),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*13+idealspritesize*13),get_sprite(0,1070),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*14+idealspritesize*14),get_sprite(0,1064),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*15+idealspritesize*15),get_sprite(0,1072),idealspritesize,idealspritesize)--
						-- value strings
						if (getShaman(i) ~= nil) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*0+idealspritesize*0)-math.floor(h/100) ," " .. _gsi.Players[i].NumPeople-1 .. "/" .. math.floor(5+(3*_gsi.Players[i].NumBuildingsOfType[1])+(5*_gsi.Players[i].NumBuildingsOfType[2])+(7*_gsi.Players[i].NumBuildingsOfType[3])),0)
						else
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*0+idealspritesize*0)-math.floor(h/100) ," " .. _gsi.Players[i].NumPeople .. "/" .. math.floor(5+(3*_gsi.Players[i].NumBuildingsOfType[1])+(5*_gsi.Players[i].NumBuildingsOfType[2])+(7*_gsi.Players[i].NumBuildingsOfType[3])),0)
						end
						local huts = _gsi.Players[i].NumBuildingsOfType[1] + _gsi.Players[i].NumBuildingsOfType[2] + _gsi.Players[i].NumBuildingsOfType[3]
						local towers = _gsi.Players[i].NumBuildingsOfType[4]
						local towers2 = ((_gsi.Players[i].NumBuiltOrPartBuiltBuildingsOfType[4])-(_gsi.Players[i].NumBuildingsOfType[4]))
						local huts2 = ((_gsi.Players[i].NumBuiltOrPartBuiltBuildingsOfType[1] + _gsi.Players[i].NumBuiltOrPartBuiltBuildingsOfType[2] + _gsi.Players[i].NumBuiltOrPartBuiltBuildingsOfType[3])-(_gsi.Players[i].NumBuildingsOfType[1] + _gsi.Players[i].NumBuildingsOfType[2] + _gsi.Players[i].NumBuildingsOfType[3]))
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*1+idealspritesize*1)-math.floor(h/100) ," " .. PLAYERS_PEOPLE_OF_TYPE(i, M_PERSON_BRAVE),0)
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*2+idealspritesize*2)-math.floor(h/100) ," " .. PLAYERS_PEOPLE_OF_TYPE(i, M_PERSON_WARRIOR) ,0)
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*3+idealspritesize*3)-math.floor(h/100) ," " .. PLAYERS_PEOPLE_OF_TYPE(i, M_PERSON_SUPER_WARRIOR) ,0)
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*4+idealspritesize*4)-math.floor(h/100) ," " .. PLAYERS_PEOPLE_OF_TYPE(i, M_PERSON_RELIGIOUS) ,0)
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*5+idealspritesize*5)-math.floor(h/100) ," " .. huts .. " | " .. huts2 ,0)
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*6+idealspritesize*6)-math.floor(h/100) ," " .. towers .. " | " .. towers2 ,0)
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_GHOST_ARMY) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*7+idealspritesize*7)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_GHOST_ARMY),0)--
						end
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_INSECT_PLAGUE) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*8+idealspritesize*8)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_INSECT_PLAGUE),0)
						end
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_LAND_BRIDGE) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*9+idealspritesize*9)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_LAND_BRIDGE),0)
						end
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_LIGHTNING_BOLT) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*10+idealspritesize*10)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_LIGHTNING_BOLT),0)
						end
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_WHIRLWIND) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*11+idealspritesize*11)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_WHIRLWIND),0)
						end
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_FLATTEN) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*12+idealspritesize*12)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_FLATTEN),0)
						end
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_EARTHQUAKE) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*13+idealspritesize*13)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_EARTHQUAKE),0)
						end
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_FIRESTORM) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*14+idealspritesize*14)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_FIRESTORM),0)
						end
						if (GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_VOLCANO) >= 1) then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*15+idealspritesize*15)-math.floor(h/100) ," " .. GET_NUM_ONE_OFF_SPELLS(i,M_SPELL_VOLCANO),0)
						end
						--charge bars
						if (pl[i].chargingGHOST == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*7+idealspritesize*7),math.floor(guiW/3),math.floor(h/50),0) --ghost army
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_GHOST_ARMY] * 100) / SPELL_COST(M_SPELL_GHOST_ARMY))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*7+idealspritesize*7),barpercent,math.floor(h/50),pl[i].color)
						end
						if (pl[i].chargingSWARM == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*8+idealspritesize*8),math.floor(guiW/3),math.floor(h/50),0) --swarm
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_INSECT_PLAGUE] * 100) / SPELL_COST(M_SPELL_INSECT_PLAGUE))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*8+idealspritesize*8),barpercent,math.floor(h/50),pl[i].color)
						end
						if (pl[i].chargingLB == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*9+idealspritesize*9),math.floor(guiW/3),math.floor(h/50),0) --lb
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_LAND_BRIDGE] * 100) / SPELL_COST(M_SPELL_LAND_BRIDGE))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*9+idealspritesize*9),barpercent,math.floor(h/50),pl[i].color)
						end
						if (pl[i].chargingLIGHT == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*10+idealspritesize*10),math.floor(guiW/3),math.floor(h/50),0) --light
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_LIGHTNING_BOLT] * 100) / SPELL_COST(M_SPELL_LIGHTNING_BOLT))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*10+idealspritesize*10),barpercent,math.floor(h/50),pl[i].color)
						end
						if (pl[i].chargingTORNADO == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*11+idealspritesize*11),math.floor(guiW/3),math.floor(h/50),0) --torn
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_WHIRLWIND] * 100) / SPELL_COST(M_SPELL_WHIRLWIND))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*11+idealspritesize*11),barpercent,math.floor(h/50),pl[i].color)
						end
						if (pl[i].chargingFLATTEN == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*12+idealspritesize*12),math.floor(guiW/3),math.floor(h/50),0) --flatten
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_FLATTEN] * 100) / SPELL_COST(M_SPELL_FLATTEN))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*12+idealspritesize*12),barpercent,math.floor(h/50),pl[i].color)
						end
						if (pl[i].chargingEQ == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*13+idealspritesize*13),math.floor(guiW/3),math.floor(h/50),0) --eq
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_EARTHQUAKE] * 100) / SPELL_COST(M_SPELL_EARTHQUAKE))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*13+idealspritesize*13),barpercent,math.floor(h/50),pl[i].color)
						end
						if (pl[i].chargingFS == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*14+idealspritesize*14),math.floor(guiW/3),math.floor(h/50),0) --fs
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_FIRESTORM] * 100) / SPELL_COST(M_SPELL_FIRESTORM))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*14+idealspritesize*14),barpercent,math.floor(h/50),pl[i].color)
						end
						if (pl[i].chargingVOLC == 1) then
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*15+idealspritesize*15),math.floor(guiW/3),math.floor(h/50),0) --volc
							local percent = math.floor((_gsi.Players[i].SpellsMana[M_SPELL_VOLCANO] * 100) / SPELL_COST(M_SPELL_VOLCANO))
							local barpercent = math.floor(((guiW/3) * percent) / 100)
							DrawBox(math.floor(guiW/2),cima+(idealspritesize*15+idealspritesize*15),barpercent,math.floor(h/50),pl[i].color)
						end
					--PAGE 2--PAGE 2--PAGE 2--PAGE 2--PAGE 2--PAGE 2--PAGE 2--PAGE 2--PAGE 2--PAGE 2--PAGE 2--PAGE 2
					else
						LbDraw_ScaledSprite(math.floor(guiW/2)-math.floor(guiW/12),math.floor((h/5)+(h/36)),get_sprite(bank,pl[i].shSprite2),math.floor(h/30),math.floor(h/30))-- shaman sprite casting
						--
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*0+idealspritesize*0),get_sprite(0,171),idealspritesize,idealspritesize)-- total spells
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*1+idealspritesize*1),get_sprite(0,1058),idealspritesize,idealspritesize)-- spells cast
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*2+idealspritesize*2),get_sprite(0,1065),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*3+idealspritesize*3),get_sprite(0,1061),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*4+idealspritesize*4),get_sprite(0,1059),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*5+idealspritesize*5),get_sprite(0,1068),idealspritesize,idealspritesize)--
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*6+idealspritesize*6),get_sprite(0,1060),idealspritesize,idealspritesize)--
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*7+idealspritesize*7),get_sprite(0,1071),idealspritesize,idealspritesize)--
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*8+idealspritesize*8),get_sprite(0,1066),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*9+idealspritesize*9),get_sprite(0,1070),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*10+idealspritesize*10),get_sprite(0,1064),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*11+idealspritesize*11),get_sprite(0,1072),idealspritesize,idealspritesize)-- 
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*12+idealspritesize*12),get_sprite(0,681),idealspritesize,idealspritesize)-- enemy units killed
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)+ idealspritesize +2 ),cima+(idealspritesize*12+idealspritesize*12),get_sprite(0,59),idealspritesize,idealspritesize)-- enemy units killed
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*13+idealspritesize*13),get_sprite(0,681),idealspritesize,idealspritesize)-- own units killed
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)+ idealspritesize + 2),cima+(idealspritesize*13+idealspritesize*13),get_sprite(0,81),idealspritesize,idealspritesize)-- own units killed
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*14+idealspritesize*14),get_sprite(1,3968),idealspritesize,idealspritesize)-- own shaman deaths
						LbDraw_ScaledSprite(math.floor((w/88)+(w/108)),cima+(idealspritesize*15+idealspritesize*15),get_sprite(0,133),idealspritesize,idealspritesize)-- camping meter
						--value strings page2
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*0+idealspritesize*0)-math.floor(h/100) ," " .. pl[i].spellsCast,0)
						if _gsi.Players[i].SpellsCast[M_SPELL_BLAST] >= 1 then
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*1+idealspritesize*1)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_BLAST],0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_GHOST_ARMY] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*2+idealspritesize*2)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_GHOST_ARMY] ,0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_INSECT_PLAGUE] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*3+idealspritesize*3)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_INSECT_PLAGUE] ,0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_LIGHTNING_BOLT] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*4+idealspritesize*4)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_LIGHTNING_BOLT] ,0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_LAND_BRIDGE] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*5+idealspritesize*5)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_LAND_BRIDGE] ,0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_WHIRLWIND] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*6+idealspritesize*6)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_WHIRLWIND] ,0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_FLATTEN] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*7+idealspritesize*7)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_FLATTEN] ,0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_EROSION] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*8+idealspritesize*8)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_EROSION] ,0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_EARTHQUAKE] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*9+idealspritesize*9)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_EARTHQUAKE] ,0)
						end	
						if _gsi.Players[i].SpellsCast[M_SPELL_FIRESTORM] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*10+idealspritesize*10)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_FIRESTORM] ,0)
						end
						if _gsi.Players[i].SpellsCast[M_SPELL_VOLCANO] >= 1 then	
							LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6),cima+(idealspritesize*11+idealspritesize*11)-math.floor(h/100) ," " .. _gsi.Players[i].SpellsCast[M_SPELL_VOLCANO] ,0)
						end
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6 + idealspritesize + 2),cima+(idealspritesize*12+idealspritesize*12)-math.floor(h/100) ," " .. pl[i].peopleKilled,0)
						local pplLost = 0
						for l = 0,7 do
							if l ~= i then
								pplLost = pplLost + _gsi.Players[l].PeopleKilled[i]
							end
						end
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6 + idealspritesize + 2),cima+(idealspritesize*13+idealspritesize*13)-math.floor(h/100) ," " .. pplLost ,0)
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6 + idealspritesize + 2),cima+(idealspritesize*14+idealspritesize*14)-math.floor(h/100) ," " .. pl[i].shDeaths ,0)
						LbDraw_Text(math.floor(((w/88)+(w/108)) + idealspritesize + 6 + idealspritesize + 2),cima+(idealspritesize*15+idealspritesize*15)-math.floor(h/100) ," " .. pl[i].camper ,0)
					end
				end
			end
		end
	end
end
