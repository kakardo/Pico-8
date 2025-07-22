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

-- TABLES AND VARIABLES
scale = 8 -- size of game steps
min = 0
max = 128

button_pushed = 1
just_moved = false
step = 1

-- game loop tick
tick_goal = 5 -- Default = 5
tick_count = 0

score = 0

---------------------------------------------------------------
--[[ TODO

All positions are successfully added and removed from
empty_cells. But, I don't think that I have implemented it well.
Kind of hate it... I will think of a better solution.

]]--

--[[ TABLES ]]--
empty_cells = {}

function _init()
	store_empty_cells(empty_cells, max, scale)
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
	 is_alive(min, max)
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