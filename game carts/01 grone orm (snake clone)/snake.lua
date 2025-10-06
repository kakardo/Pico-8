--[[ SNAKE.LUA 
	- Functions connected to the body
	  and head of the snake.
	@date 2025-07-14
	
	FUNCTIONS
	- init_head()
	- init_body()
	- update_snake(button_pushed)
	- update_tail_dir(x, y, segment)
	- calculate_body_piece(old_dir, new_dir)
	- add_new_shape(shape_index)
	- check_if_safe(new_dir, x, y)
	- move_head(direction)
	- draw_snake()
	- draw_tail()
	- convert_to_tail(dir1, dir2, shape1, shape2)
	- get_shape(index)
  - is_alive(min, max)
]]--

-- TABLES AND VARIABLES
head = {}
body = {}

local snake_starting_length = 11
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
		pos_dir = {},
		tail_dir = 1, --Right
		last_tail_pos_x = -1,
		last_tail_pos_y = -1,
	}

	-- Build by looping once for each segment.
	local starting_x_pos = snake_starting_coordinate
	
	for i = 1, body.segments, 1 do
		starting_x_pos -= scale
		add(body.x, starting_x_pos)
		add(body.y, snake_starting_coordinate)

		a = starting_x_pos
		b = snake_starting_coordinate
		
		-- TEST FOR BODY ANIMATION
		body.pos_dir[convert_coordinate_to_index(a,b)] = 6
		print(body.pos_dir[convert_coordinate_to_index(a,b)])

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
	old_dir = head.dir

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
			-- Remove to have snake only turn if button is
			-- is pressed correctly on a possible path.
			-- Include this to have snake take chosen turn when possible
			--ignore_button_push(head.dir)

			head.x = last_head_pos_x
			head.y = last_head_pos_y
			new_dir = head.dir

			move_head(new_dir)
		else
			head.dir = new_dir
		end
		
		-- Move body
		body.last_tail_pos_x = body.x[body.segments]
		body.last_tail_pos_y = body.y[body.segments]
		
		-- Tail update
		update_tail_dir(body.x, body.y, body.segments)
		deli(body.x, body.segments)
		deli(body.y, body.segments)
		
		add(body.x, last_head_pos_x, 1)
		add(body.y, last_head_pos_y, 1)
		
		--print("NewDir:"..head.dir.." OldDir:"..old_dir)
		calculate_body_piece(old_dir, head.dir)
		
		empty_cells_occupy(empty_cells, head.x, head.y)
		empty_cells_free(empty_cells,
		body.last_tail_pos_x, body.last_tail_pos_y)
	else
		head.alive = false
	end
end

function update_tail_dir(x, y, segment)
	if x[segment-1] == x[segment-2] then
		if y[segment-1] > y[segment-2] then
			body.tail_dir = 2
		else
			body.tail_dir = 3
		end
	elseif y[segment-1] == y[segment-2] then
		if x[segment-1] > x[segment-2] then
			body.tail_dir = 0
		else
			body.tail_dir = 1
		end
	end
end

function calculate_body_piece(old_dir, new_dir)
	--print("NewDir:"..new_dir.." OldDir:"..old_dir)
	if (old_dir == new_dir) then
		if (new_dir == 0 or new_dir == 1) then
			add_new_shape(6)
		elseif (new_dir == 2 or new_dir == 3) then
			add_new_shape(7)
		end
	elseif (old_dir == 0 and new_dir == 3) or
           (old_dir == 2 and new_dir == 1) then
			add_new_shape(8)
	elseif (old_dir == 1 and new_dir == 3) or
           (old_dir == 2 and new_dir == 0) then
			add_new_shape(9)
	elseif (old_dir == 0 and new_dir == 2) or
           (old_dir == 3 and new_dir == 1) then
			add_new_shape(10)
	elseif (old_dir == 1 and new_dir == 2) or
		   (old_dir == 3 and new_dir == 0) then
			add_new_shape(11)
	else
		printh("calculate_body_piece: old_dir:"..old_dir.." new_dir: "..new_dir)
		add_new_shape(32) --error
	end
end

function add_new_shape(shape_index)
	index = convert_coordinate_to_index(body.x[1],body.y[1])
	body.pos_dir[index] = shape_index
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

	local tail_x = body.x[body.segments]
	local tail_y = body.y[body.segments]
	local will_grow = (x == fruit.x and y == fruit.y)
	
	-- Current tail tile will move away unless we grow by eating
	if not will_grow and (x == tail_x and y == tail_y) then
		return true
	end

	-- Current tile != tail tile, so run regular check
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
	-- Draw head with direction
	if head.dir == 0 then
		spr(0,head.x,head.y)
	elseif head.dir == 1 then
		spr(1,head.x,head.y)
	elseif head.dir == 2 then
		spr(2,head.x,head.y)
	elseif head.dir == 3 then
		spr(3,head.x,head.y)
	end

	-- Draw body
	if body.segments > 0 then
		-- body.segments-1 = to not draw the last piece
		-- and save the spot for a tail.			
		for i = body.segments-1, 1, -1 do
			spr(get_shape(i), body.x[i], body.y[i])
		end

		draw_tail()
	end
end

function draw_tail()
	last_segment = get_shape(body.segments)
	new_tail_shape = 32	

	-- Horizontal shape
	if last_segment == 6 then
		new_tail_shape = convert_to_tail(0, 1, 16, 17)
	-- Vertical Shape
	elseif last_segment == 7 then
		new_tail_shape = convert_to_tail(2, 3, 18, 19)
	-- Corner Shape
	elseif last_segment == 8 then -- NW
		new_tail_shape = convert_to_tail(1, 3, 17, 19)
	elseif last_segment == 9 then -- NE
		new_tail_shape = convert_to_tail(0, 3, 16, 19)
	elseif last_segment == 10 then -- SW
		new_tail_shape = convert_to_tail(1, 2, 17, 18)
	elseif last_segment == 11 then -- SE
		new_tail_shape = convert_to_tail(0, 2, 16, 18)
	end

	if new_tail_shape == 32 then
		printh("Snake.draw_tail\n- New tail shape: "..new_tail_shape)
		printh("- body.segments: "..body.segments)
		printh("- last_segment: "..last_segment)
		printh("- body.tail_dir: "..body.tail_dir)
	end

	spr(new_tail_shape, body.x[body.segments], body.y[body.segments])
end

function convert_to_tail(dir1, dir2, shape1, shape2)
	if body.tail_dir == dir1 then
		return shape1
	elseif body.tail_dir == dir2 then
		return shape2
	else
		return 32 --error
	end
end

function get_shape(index)
	x = body.x[index]
	y = body.y[index]
	shape_i = convert_coordinate_to_index(x, y)
	return body.pos_dir[shape_i]
end

-- Checks if the snake is within bounds
function is_alive(min, max)
	if head.x < min or head.x >= max or
	   head.y < min or head.y >= max then
		head.alive = false
	end
end

// LAST_LINE_OF_SNAKE_LUA