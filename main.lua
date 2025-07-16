--[[ MAIN.LUA
	- Main loop of the program.
	@author Kardo Rostam

	@date 2025-07-14
	@version 1.0
	- Basic gameplay:	
		# Fruit spawns (always one on field).
		# Snake can eat fruit to grow.
		# Crude game over screen.
		# Scoreboard.
	- Four colors (not black and white!).
	- No going backwards into body.

	@version 1.1
	
	Features
	Visuals
	
	TODO
	- Die when crashing into eats own body.
	- No fruit spawn untop of the snake.
	- Increase speed at certain lengths.
	- Possibility to dash for higher score.
	- [VISUAL] Game over screen.
	- [VISUAL] Start screen.
	- [VISUAL] Visually linked snake. Path taken's visible.
	- [VISUAL] Game border.
	- [VISUAL] Multiple fruit types.
	- [SOUND] Fruit
	- [SOUND] Snake crawl
	- [SOUND] Game over
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
	debug() -- Not part of ready game

	print(count(empty_cells))

	--print("SCORE = "..score)
	check_button_push()

	if (just_moved == false) then
	 move()
	 is_alive()
	 is_fruit_eaten()
	elseif tick_count == tick_goal then
		just_moved = false
		tick_count = 0
	else
	 tick_count += 1
	end
end

function _draw()
	if head.alive then
		draw_snake()
		draw_fruit()
	else
		--print("game over")
	end
end






// LAST_LINE_MAIN_LUA