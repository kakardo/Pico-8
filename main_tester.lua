--[[ MAIN_TESTER.LUA
	- Testing enviroment for the snake game.
	@author Kardo Rostam
]]--

head = {}
body = {}
fruit = {}
empty_cells = {}

scale = 8 -- size of game steps
max = 128

button_pushed = 1
just_moved = false
step = 1

-- game loop tick
tick_goal = 15 -- Default = 5
tick_count = 0

score = 0

---------------------------------------------------------------

function store_empty_cells()
	for y = 0, max-1, scale do
		for x = 0, max-1, scale do
			add(empty_cells, convert_coordinate_to_index(x, y))
		end
	end
end

function convert_coordinate_to_index(x, y)
	new_pos = y * max + x
	return new_pos
end

function empty_cells_occupy(x, y)
	print(x.." "..y)
	del(empty_cells, convert_coordinate_to_index(x, y))
end

function empty_cells_free(x, y)
	print(x.." "..y)
	add(empty_cells, convert_coordinate_to_index(x, y))
end

---------------------------------------------------------------

-- TODO Fix empty cell count bug

function _init()
	store_empty_cells()
	init_head()
	init_body()
	init_fruit()
end

function _update()
	cls(1)
end

function _draw()
end

// LAST_LINE_MAIN_TESTER_LUA