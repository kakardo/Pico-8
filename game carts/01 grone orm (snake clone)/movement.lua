--[[ MOVEMENT.LUA 
	- Functions connected to the movement
	  of the snake.
	@date 2025-07-14

	FUNCTIONS
	- check_button_push()
	- ignore_button_push(previous_button_input)
	- move()
	- avert_going_backwards()
	
	DIRECTIONS
	0 = left
	1 = right
	2 = up
	3 = down
]]--

-- Stores pressed button direction until move update
function check_button_push()
	if (btn(0))	then
		button_pushed = 0 -- LEFT
	elseif (btn(1)) then
		button_pushed = 1 -- RIGHT
	elseif (btn(2)) then
		button_pushed = 2 -- UP
	elseif (btn(3)) then
		button_pushed = 3 -- DOWN
	end
end

-- Toggle in snake.lua -> update_snake()
function ignore_button_push(previous_button_input)
	button_pushed = previous_button_input
end

-- Move snake and update variable "just_moved" to TRUE
function move()
	avert_going_backwards()
	update_snake(button_pushed)
	just_moved = true
end

function avert_going_backwards()
	if button_pushed == 0 and head.dir == 1 then
		button_pushed = head.dir
	elseif button_pushed == 1 and head.dir == 0 then
		button_pushed = head.dir
	elseif button_pushed == 2 and head.dir == 3 then
		button_pushed = head.dir
	elseif button_pushed == 3 and head.dir == 2 then
		button_pushed = head.dir
	end
end

// LAST_LINE_OF_MOVEMENT_LUA