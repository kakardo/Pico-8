--[[ DEBUG.LUA
	- Made to track and surveil the game.
	@date 2025-07-14

	FUNCTIONS
	- debug()	
]]--

function debug()
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

// LAST_LINE_SNAKE_EXTERNAL_LUA