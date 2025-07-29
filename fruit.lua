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

function init_fruit()
	fruit.x = 0
	fruit.y = 0
	spawn_fruit()
end

function spawn_fruit()	
	-- Converts available fruit coordinate to X & Y positions
	-- No scale multiplier added yet
	index = flr(rnd(#available_cells))
	coordinate = available_cells[index]
	new_x = coordinate % max
	new_y = flr(coordinate / max)
	--printh("Fruit coordinate:"..coordinate.." [index:"..index.."] (x:"..new_x..".y:"..new_y..")")
	
	-- POSITION BOUNDARIES = min: 0, max: 15
	fruit.y = new_y * scale
	fruit.x = new_x * scale

	empty_cells_occupy(empty_cells, fruit.x, fruit.y)
end

function draw_fruit()
	spr(1,fruit.x,fruit.y)
end

function is_fruit_eaten()
	if head.x == fruit.x and head.y == fruit.y then
		body.segments += 1
		add(body.x, body.last_tail_pos_x)
		add(body.y, body.last_tail_pos_y)

		score += 10

		--printh("F.X: "..fruit.x.." F.Y:"..fruit.y)
		empty_cells_free(empty_cells, fruit.x, fruit.y)
		spawn_fruit()
	end
end

// LAST_LINE_FRUIT_LUA