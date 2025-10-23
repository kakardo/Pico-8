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
fruit_basket = {}
fruit_basket_i = 1

function init_fruit()
	fruit.x = 0
	fruit.y = 0
	refill_fruit_basket()
	spawn_fruit()
end

function refill_fruit_basket()
	fruit_basket = {}

	for s = 48, 55 do
		add(fruit_basket, s)
	end

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
	-- Converts available fruit coordinate to X & Y positions
	-- No scale multiplier added yet
	index = flr(rnd(#available_cells)) + 1
	coordinate = available_cells[index]
	new_x = coordinate % max
	new_y = flr(coordinate / max)
	--printh("Fruit coordinate:"..coordinate.." [index:"..index.."] (x:"..new_x..".y:"..new_y..")")
	
	-- POSITION BOUNDARIES = min: 0, max: 15
	fruit.y = new_y * scale
	fruit.x = new_x * scale

	empty_cells_occupy(empty_cells, fruit.x, fruit.y)
	current_fruit = next_fruit_sprite()
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