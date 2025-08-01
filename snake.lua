--[[ MOVEMENT.LUA 
	- Functions connected to the body
	  and head of the snake.
	@date 2025-07-14
	
	FUNCTIONS
	- init_head()
	- init_body()
	- update_snake()
	- draw_snake()
	- is_alive()
]]--

-- TABLES AND VARIABLES
head = {}
body = {}

local snake_starting_length = 8
local snake_starting_coordinate = 64
local snake_starting_direction = 1

local last_head_pos_x = -1
local last_head_pos_y = -1

function init_head()
	head = {
		x = snake_starting_coordinate,
		y = snake_starting_coordinate,
		dir = snake_starting_direction,
		alive = true
	}
		
	-- Add occupied cells to empty_cells-table
	empty_cells_occupy(empty_cells, head.x, head.y)
end

function init_body()
	body = {
		segments = snake_starting_length,
		x = {},
		y = {},
		last_tail_pos_x = -1,
		last_tail_pos_y = -1,
	}

	-- Build by looping once for each segment.
	local starting_x_pos = snake_starting_coordinate
	
	for i = 1, body.segments, 1 do
		starting_x_pos -= scale
		add(body.x, starting_x_pos)
		add(body.y, snake_starting_coordinate)
		
		-- Add occupied cells to empty_cells-table
		empty_cells_occupy(empty_cells, body.x[i], body.y[i])
	end
	
	starting_x_pos -= scale
	body.last_tail_pos_x = starting_x_pos
	body.last_tail_pos_y = snake_starting_coordinate
end

-- Update the snakes movement table.
function update_snake(button_pushed)
	new_dir = button_pushed
	
	isTurningSafe = check_if_safe(new_dir, head.x, head.y)
	isForwardSafe = check_if_safe(head.dir, head.x, head.y)
	
	-- TODO This whole section needs a clean up
	
	last_head_pos_x = head.x
	last_head_pos_y = head.y
	move_head(new_dir)

	-- Is occupied space the fruit?
	if head.x == fruit.x and head.y == fruit.y then
		isForwardSafe = true
	end

	-- TODO make it an option if player wants this safety net
	if isTurningSafe or isForwardSafe then
		if not isTurningSafe then
			print("YES")
			
			-- remove this to have snake take chosen turn when possible
			ignore_button_push(head.dir)

			head.x = last_head_pos_x
			head.y = last_head_pos_y
			new_dir = head.dir

			move_head(new_dir)
		else
			print("NO")
			head.dir = new_dir
		end
		
		-- Move body
		body.last_tail_pos_x = body.x[body.segments]
		body.last_tail_pos_y = body.y[body.segments]
		
		deli(body.x, body.segments)
		deli(body.y, body.segments)
		
		add(body.x, last_head_pos_x, 1)
		add(body.y, last_head_pos_y, 1)
		
		empty_cells_occupy(empty_cells, head.x, head.y)
		empty_cells_free(empty_cells,
		body.last_tail_pos_x, body.last_tail_pos_y)
	else
		head.alive = false
	end
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
	
	if is_occupied(empty_cells, x, y) then
		return false
	else
		return true
	end
end

function move_head(direction)
	if (direction == 0) then
		head.x += scale * (-step) -- LEFT
	elseif (direction == 1) then
		head.x += scale * (step) -- RIGHT
	elseif (direction == 2) then
		head.y += scale * (-step) -- UP
	elseif (direction == 3) then
		head.y += scale * (step) -- DOWN
	end
end

-- Draw snake with its table as reference.
function draw_snake()
	-- Draw head
	spr(0,head.x,head.y)
	
	-- Draw body
	if body.segments > 0 then
		for i = body.segments, 1, -1 do
			spr(0,body.x[i],body.y[i])
		end
	end
end

-- Checks if the snake is within bounds
function is_alive(min, max)
	if head.x < min or head.x >= max or
	   head.y < min or head.y >= max then
		head.alive = false
	end
end

// LAST_LINE_SNAKE_LUA