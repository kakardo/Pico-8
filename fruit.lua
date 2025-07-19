--[[ FRUIT.LUA 
	- Functions connected the fruit which
	  the snake crave more than anything.
	@date 2025-07-15 1.0.1	

	FUNCTIONS
	- init_fruit()
	- draw_fruit()
	- spawn_fruit()
	- is_fruit_eaten()
]]--

-- TABLES AND VARIABLES
fruit = {}

function init_fruit()
	fruit.x = 0
	fruit.y = 0
	spawn_fruit()
end

function draw_fruit()
	spr(1,fruit.x,fruit.y)
end

function spawn_fruit()
	fruit.x = flr(rnd(128 / scale)) * scale
	fruit.y = flr(rnd(128 / scale)) * scale

	empty_cells_occupy(fruit.x, fruit.y)
end

function is_fruit_eaten()
	if head.x == fruit.x and head.y == fruit.y then
		body.segments += 1
		body.x[body.segments] = fruit.x
		body.y[body.segments] = fruit.y

		score += 10

		--empty_cells_free(fruit.x, fruit.y)
		spawn_fruit()	
	end
end

// LAST_LINE_FRUIT_LUA