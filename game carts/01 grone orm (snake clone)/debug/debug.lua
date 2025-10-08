--[[ DEBUG.LUA
	- Made to track and surveil the game.
	@date 2025-07-14

	FUNCTIONS
	- debug()	
]]--

function debug()
	game_state_checker() -- Not part of ready game
	--snake_and_fruit_tester()
	--coordinat_tester()
end

function snake_and_fruit_tester()
	print('X = '..head.x)
	print('Y = '..head.y)

	if head.alive then
	 print('Alive = TRUE')
	else
	 print('Alive = FALSE')
	end

	-- Resurrect snake for debugging purposes
	if head.x >= 1 and head.x <= 128 and
	   head.y >= 1 and head.y <= 128 then
		head.alive = true
	end

	print('Length = '..body.segments)
	print('Frukt x = '..fruit.x)
	print('Frukt y = '..fruit.y)
end

function coordinat_tester()
	print("")
	print("")
	for i = 0, max-1, scale do
		rect(i, 0, i+scale-1, scale-1, 14) -- X-coordinate
		rect(0, i, scale-1, i+scale-1, 9) -- Y-coordinate
		print("   "..i.." "..i+scale-1)
	end
	
	-- Count amount of cells
	print(count(empty_cells))

end

function game_state_checker()	
	if #body.x != #body.y then
		print("X and Y total's not the same!")
	elseif body.segments != #body.x then
		print("Body segments not equal to X!")
	elseif body.segments != #body.y then
		print("Body segments not equal to X!")
	end

	-- Test prints
	if print_tests then
		used_cells = 256 - count(empty_cells)
		print("empty_cells:"..count(empty_cells)..
			  " (used:"..used_cells..")")
		print("available:"..#available_cells)
		print("segments:"..body.segments..
			  ' X = '..head.x..' Y = '..head.y)
		--print("button pushed "..button_pushed.." -> head.dir "..head.dir)

		--print("AV-CELLS:"..available_cells[ceil(#available_cells)])
		--print("available:"..available_cells[flr(rnd(#available_cells))])
	end
end

-- LAST_LINE_DEBUG_LUA