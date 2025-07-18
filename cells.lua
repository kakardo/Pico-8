--[[ CELLS.LUA 
	- 
	@date 2025-07-18
	
	FUNCTIONS
	-
]]--

-- TABLE
empty_cells = {}

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

// LAST_LINE_CELLS_LUA