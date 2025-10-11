--[[ MOVEMENT.LUA 
	- Functions connected to the movement of the snake.
	@date 2025-07-14

	FUNCTIONS
	- check_button_push()
	- ignore_button_push(previous_button_input)
	- move()
	
	DIRECTIONS
	0 = left
	1 = right
	2 = up
	3 = down
]]--

-- Stores pressed button direction until move update
function check_button_push()
	local dir = -1

	if (btn(0))	dir = 0 -- LEFT
	if (btn(1)) dir = 1 -- RIGHT
	if (btn(2)) dir = 2 -- UP
	if (btn(3)) dir = 3 -- DOWN
	if dir == -1 then
		return
	end

	-- Avert going backwards
	if (dir == 0 and head.dir == 1) or
		 (dir == 1 and head.dir == 0) or
	   (dir == 2 and head.dir == 3) or
	   (dir == 3 and head.dir == 2) then
		return -- Don't save input
	end
	
	update_next_dir(dir)
end


-- Move snake and update variable "just_moved" to TRUE
function move()
	update_snake()
	just_moved = true
end


function check_if_safe(new_dir, x, y)
	if (new_dir == 0) then
		x += scale * (-step) -- LEFT
	elseif (new_dir == 1) then
		x += scale * (step) -- RIGHT
	elseif (new_dir == 2) then
		y += scale * (-step) -- UP
	elseif (new_dir == 3) then
		y += scale * (step) -- DOWN
	end
	
	-- Check bounds
	if x < min or x >= max or y < min or y >= max then
		return false
	end

	if x == fruit.x and y == fruit.y then
		return true
	end

	local tail_x = body.x[body.segments]
	local tail_y = body.y[body.segments]
	local will_grow = (x == fruit.x and y == fruit.y)
	
	-- Current tail tile will move away unless we grow by eating
	if (not will_grow) and (x == tail_x and y == tail_y) then
		return true
	end

	-- Current tile != tail tile, so run regular check
	if is_occupied(empty_cells, x, y) then
		return false
	else
		return true
	end
end

-- LAST_LINE_OF_MOVEMENT_LUA