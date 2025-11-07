--[[ FRUIT.LUA 
	- Functions connected the fruit which
	  the snake crave more than anything.
	@date 2025-07-15 1.0.1	

	FUNCTIONS
	- init_fruit()
	- spawn_fruit()
	- draw_fruit()
	- is_fruit_eaten()
]]--

-- TABLES AND VARIABLES
fruit = {}
fruit_basket = {22,23,24,25,26,27,28,29}
fruit_basket_i = 1

function init_fruit()
	fruit.x = 0
	fruit.y = 0
	refill_fruit_basket()
	spawn_fruit()
end

function refill_fruit_basket()
	-- Fisher-Yates shuffle
	for i = #fruit_basket, 2, -1 do
		local j = flr(rnd(i)) + 1
    fruit_basket[i], fruit_basket[j] = fruit_basket[j], fruit_basket[i]
	end

	fruit_basket_i = 1
end

function next_fruit_sprite()
	if fruit_basket_i > #fruit_basket then
		refill_fruit_basket()
	end

	local s = fruit_basket[fruit_basket_i]
  fruit_basket_i += 1

	return s
end



function spawn_fruit()
	-- Collect all free cells as fruit candidates
	local candidates = {}
	for yy = min, max - 1, scale do
		for xx = min, max - 1, scale do
			if is_fruit_cell_free(xx, yy) then
				add(candidates, {x=xx, y=yy})
			end
		end
	end
	
	-- If no space left, spawn no fruit
	-- TODO Add win screen
	if #candidates == 0 then
		fruit.x = -1
		fruit.y = -1
		return
	end

	-- Converts available fruit coordinate to X & Y positions
	-- No scale multiplier added yet
	local index = flr(rnd(#candidates)) + 1
	local coordinate = candidates[index]
	
	-- POSITION BOUNDARIES = min: 0, max: 15
	fruit.x = coordinate.x
	fruit.y = coordinate.y

	current_fruit = next_fruit_sprite()
	empty_cells_occupy(empty_cells, fruit.x, fruit.y)
end



function is_fruit_cell_free(x, y)
	-- Is the head?
	if (x == head.x and y == head.y) then
		return false
	end

	-- Is body?
	for i = 1, body.segments do
		if (x == body.x[i] and y == body.y[i]) then
			return false
		end
	end

	-- Is not head or body = free
	return true
end

function draw_fruit()
	spr(current_fruit, fruit.x, fruit.y)
end

function is_fruit_eaten()
	if head.x == fruit.x and head.y == fruit.y then
		body.segments += 1
		add(body.x, body.last_tail_pos_x)
		add(body.y, body.last_tail_pos_y)
		empty_cells_occupy(empty_cells, body.last_tail_pos_x, body.last_tail_pos_y)

		-- Assign shape for new last segment (after growing)
		local previous_pos = convert_coordinate_to_index(
			body.x[body.segments - 1], body.y[body.segments - 1]
		)
		local new_pos = convert_coordinate_to_index(
			body.x[body.segments], body.y[body.segments]
		)
		body.pos_dir[new_pos] = body.pos_dir[previous_pos]

    update_tail_dir(body.x, body.y, body.segments)

		score += 10
		empty_cells_free(empty_cells, fruit.x, fruit.y)
		spawn_fruit()
	end
end

// LAST_LINE_OF_FRUIT_LUA