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

// LAST_LINE_OF_MOVEMENT_LUA