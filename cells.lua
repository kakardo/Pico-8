--[[ CELLS.LUA 
	- 
	@date 2025-07-18
	
	FUNCTIONS
	-
]]--

-- TABLES AND VARIABLES
empty_cells = {}

function store_empty_cells(max, scale)
	for y = 0, max-1, scale do
		for x = 0, max-1, scale do
			add(empty_cells, convert_coordinate_to_index(x, y))
		end
	end
end

function convert_coordinate_to_index(x, y)
	return y * max + x
end

function empty_cells_occupy(del_x, del_y)
	del(empty_cells,
			convert_coordinate_to_index(del_x, del_y))
end

function empty_cells_free(add_x, add_y)
	add(empty_cells,
			convert_coordinate_to_index(add_x, add_y))
end

// LAST_LINE_CELLS_LUA