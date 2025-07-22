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

local snake_starting_length = 4
local snake_starting_coordinate = 64
local snake_starting_direction = 1

local last_head_pos_x = -1
local last_head_pos_y = -1

function init_head()
	head.x = snake_starting_coordinate
	head.y = snake_starting_coordinate
	head.dir = snake_starting_direction
	head.alive = true
	
	-- Add occupied cells to empty_cells-table
	empty_cells_occupy(empty_cells, head.x, head.y)
end

function init_body()
	body.segments = snake_starting_length
	body.x = {}
	body.y = {}
	body.last_tail_pos_x = -1
	body.last_tail_pos_y = -1

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
	-- Add occupied cells to empty_cells-table
	--empty_cells_free(body.x[body.segments], body.y[body.segments])
	--empty_cells_occupy(body.x[head.x], body.y[head.y])

	head.dir = button_pushed
	
	last_head_pos_x = head.x
	last_head_pos_y = head.y
	
	-- Move head
	if (head.dir == 0) then
		head.x += scale * (-step) -- LEFT
	elseif (head.dir == 1) then
		head.x += scale * (step) -- RIGHT
	elseif (head.dir == 2) then
		head.y += scale * (-step) -- UP
	elseif (head.dir == 3) then
		head.y += scale * (step) -- DOWN
	end
	
	-- Move body
	body.last_tail_pos_x = body.x[body.segments]
	body.last_tail_pos_y = body.y[body.segments]
	
	del(body.x, body.segments)
	del(body.y, body.segments)
	
	add(body.x, last_head_pos_x, 1)
	add(body.y, last_head_pos_y, 1)
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
	if head.x < min or head.x > max or
	   head.y < min or head.y > max then
		head.alive = false
	end
end

// LAST_LINE_SNAKE_LUA