local units = {}
local window = { w = 600, h = 600, x = 340, y = 60, color = 173, outline_color = 130, units_speed = 2, units_size = 24 }
local scores = { 0, 0, 0 }

local _m = math
local unit_size = window.units_size
local half_unit = _m.floor(unit_size / 2)
local half_window_w, half_window_h = _m.floor(window.w / 2), _m.floor(window.h / 2)
local quarter_window_w = _m.floor(window.w / 4)
local third_window_w, sixth_window_h = _m.floor(window.h / 3), _m.floor(window.h / 6)
local limitX, limitY = window.x, window.y
local limitW, limitH = limitX + window.w - unit_size, limitY + window.h - unit_size
local spawn_amt = 5
local mouse_hovering = false
local process = false

local units_tbl = {
						{ snd = 39,		weakness = 2, 	sprite = get_hfx_sprite(76), 	start = { window.x + half_window_w - half_unit, window.y + sixth_window_h } }, --w
						{ snd = 51, 	weakness = 3, 	sprite = get_hfx_sprite(179), 	start = { window.x + quarter_window_w - half_unit, window.y + window.h - third_window_w - window.units_size } }, --p
						{ snd = 161, 	weakness = 1, 	sprite = get_hfx_sprite(670), 	start = { window.x + window.w - quarter_window_w - half_unit, window.y + window.h - third_window_w - window.units_size } }, --fw
}

local buttons = {
					{ text = "more units",					effect = function() spawn_amt = spawn_amt + 1 end },
					{ text = "less units",					effect = function() spawn_amt = _m.max(1, spawn_amt - 1) end },
					
					{ text = "spawn %i more",				effect = function() spawn_units() end },
					{ text = "clear board",					effect = function() units = {} end },
					{ text = "+ speed",						effect = function() window.units_speed = window.units_speed + 1 end },
					{ text = "- speed",						effect = function() window.units_speed = _m.max(1, window.units_speed - 1) end },
}


function OnFrame()
	draw_board()
	draw_units()
	process_units()
	check_collisions()
	draw_buttons()
	draw_score()
end




function draw_score()
	PopSetFont(9, 0)
	local txt = string.format("Warrior: %i   Preacher: %i   FireWarrior: %i", scores[1], scores[2], scores[3])
	local txt_w = string_width(txt)
	
	DrawTextStr(limitX + half_window_w - _m.floor(txt_w / 2), limitY - CharHeight(), txt)
end

function draw_buttons()
	local hover = false
	PopSetFont(9, 0)
	local o = 2
	local ox = 8
	local curr_x = limitX
	local y = window.y + window.h + 4
	local btns_h = CharHeight()
	local half_btn_h = _m.floor(btns_h / 2)
	
	for i = 1, 2 do
		local bool = btn(i == 2)
		local spr = 421 + 3*bool
		local offset = (half_btn_h + 1) * bool
		
		if not hover then
			if isCursorInsideSquare2(curr_x, y + offset, 16, half_btn_h) then
				hover = true
				mouse_hovering = i
				spr = spr + 1
			end
		end
		
		DrawBox(curr_x, y + offset, 16, half_btn_h, 173)
		DrawBoxOutline(curr_x-1, y + offset-1, 16+2, half_btn_h+2, 130)
		LbDraw_ScaledSprite(curr_x, y + offset, get_hfx_sprite(spr), 16, half_btn_h)
	end
	
	curr_x = curr_x + half_btn_h + ox
	y = y + 1
	
	for i = 1, 4 do
		local txt = string.format(buttons[i + 2].text, spawn_amt)
		local w = string_width(txt) + o * 2
		local x = curr_x + (i-1) * ox
		local clr_out = 130
		
		if not hover then
			if isCursorInsideSquare2(x, y, w, btns_h) then
				hover = true
				mouse_hovering = i + 2
				clr_out = 155
			end
		end
		
		DrawBox(x-1, y-1, w+2, btns_h+2, clr_out)
		DrawBox(x, y, w, btns_h, 173)
		DrawTextStr(x + o, y, txt)
		
		curr_x = curr_x + w + ox * 2
	end
	
	if not hover then
		mouse_hovering = false
	end
end

function game_has_ended()
	local amt = #units
	local winner_type = -1
	
	if amt > 0 then
		winner_type = units[1].TYPE
		
		for i = 2, amt do
			if units[i].TYPE ~= winner_type then
				return false
			end
		end
	else
		return false
	end
	
	scores[winner_type] = scores[winner_type] + 1
	
	return true
end

function check_collisions()
	if process then
		for k, unit in ipairs(units) do
			local x, y = unit.POS[1], unit.POS[2]
			local mx, my = x + unit_size, y + unit_size
			local t1 = unit.TYPE
		
			for kk, unit2 in ipairs(units) do
				if k < kk then
					local x2, y2 = unit2.POS[1], unit2.POS[2]
					local mx2, my2 = x2 + unit_size, y2 + unit_size
					local t2 = unit2.TYPE
					
					if t1 ~= t2 then
						if mx >= x2 then
							if x <= mx2 then
								if my >= y2 then
									if y <= my2 then
										if units_tbl[t2].weakness == t1 then
											--t1 win
											unit2.TYPE = t1
											unit2.SPR = units_tbl[t1].sprite
											play_sound_event(nil, units_tbl[t1].snd, 1)
										else
											--t2 wins
											unit.TYPE = t2
											unit.SPR = units_tbl[t2].sprite
											play_sound_event(nil, units_tbl[t2].snd, 1)
										end
										
										unit.DIR[1] = _m.random(-1, 1)
										unit.DIR[2] = _m.random(-1, 1)
										unit2.DIR[1] = _m.random(-1, 1)
										unit2.DIR[2] = _m.random(-1, 1)
									end
								end
							end
						end
					end
				end
			end
		end
		
		if game_has_ended() then
			process = false
		end
	end
end

function process_units()
	if process then
		local speed = window.units_speed
		
		for k, unit in ipairs(units) do
			local _speed_x = _m.max(1, speed + _m.random(-1, 1))
			local _speed_y = _m.max(1, speed + _m.random(-1, 1))
			local x, y = unit.POS[1], unit.POS[2]
			local dir_x, dir_y = unit.DIR[1], unit.DIR[2]
			local new_x, new_y = x + (_speed_x * dir_x), y + (_speed_y * dir_y)
			local new_dir_x, new_dir_y = dir_x, dir_y
			
			if new_x > limitW then
				new_x = limitW
				new_dir_x = new_dir_x * -1
			elseif new_x < limitX then
				new_x = limitX
				new_dir_x = new_dir_x * -1
			end
		
			if new_y > limitH then
				new_y = limitH
				new_dir_y = new_dir_y * -1
			elseif new_y < limitY then
				new_y = limitY
				new_dir_y = new_dir_y * -1
			end
			
			if new_dir_x == 0 then
				new_dir_x = _m.random(-1, 1)
			end
			
			if new_dir_y == 0 then
				new_dir_y = _m.random(-1, 1)
			end
			
			if _m.random(100) < 2 then
				new_dir_x = new_dir_x * -1
			end
			
			if _m.random(100) < 2 then
				new_dir_y = new_dir_y * -1
			end
			
			unit.POS[1] = new_x
			unit.POS[2] = new_y
			unit.DIR[1] = new_dir_x
			unit.DIR[2] = new_dir_y
		end
	end
end

function draw_units()
	for k, unit in ipairs(units) do
		LbDraw_ScaledSprite(unit.POS[1], unit.POS[2], unit.SPR, unit_size, unit_size)
	end
end

function spawn_units()
	for _type = 1, 3 do
		local type_tbl = units_tbl[_type]
		local pos = {type_tbl.start[1], type_tbl.start[2]}
		local spr = type_tbl.sprite
		
		for i = 1, spawn_amt do
			local _pos = copy_table(pos)
			local offset_x, offset_y = _m.random(-6, 6), _m.random(-6, 6)
			_pos[1] = pos[1] + offset_x
			_pos[2] = pos[2] + offset_y
			local direction = { _m.random(-1, 1), _m.random(-1, 1) }
			
			if direction[1] == 0 and direction[2] == 0 then
				direction[1] = iipp(-1, 1, 50, 50)
				direction[2] = iipp(-1, 1, 50, 50)
			end

			local unit = { TYPE = _type, SPR = spr, POS = _pos, DIR = direction }
			table.insert(units, unit)
		end
	end
	
	process = true
end

function draw_board()
	DrawBox(window.x, window.y, window.w, window.h, window.color)
	DrawBoxOutline(window.x-1, window.y-1, window.w+2, window.h+2, window.outline_color)
end

function iipp(i1, i2, p1, p2)
	local chance = _m.random()
	
	if chance <= p1 then
		return i1
	end
	
	return i2
end

function btn(bool)
	if not bool then
		return 0
	end
	
	return 1
end

function isCursorInsideSquare(Xmin,Xmax,Ymin,Ymax)
	local Xcurr,Ycurr = Mouse.getScreenX(),Mouse.getScreenY()

	if Xcurr > Xmin and Xcurr <= Xmax then
		if Ycurr > Ymin and Ycurr <= Ymax then
			return true
		end
	end
	return false
end

function isCursorInsideSquare2(x, y, w, h)
	local a,b,c,d = x, x + w, y, y + h
	
	return isCursorInsideSquare(a, b, c, d)
end

function copy_table(tbl)
	local newtbl = {}
	local idx = 1
	
	for k, v in ipairs(tbl) do
		newtbl[idx] = v
		idx = idx + 1
	end
	
	return newtbl
end


function OnMouse(e)
	local down = e.Down		
	local left = (e.Button == TbInputKey.LB_KEY_MOUSE0)

	if left then
		if not down then
			if mouse_hovering ~= false then
				buttons[mouse_hovering].effect()
			end
		end
	end
	
	return false
end