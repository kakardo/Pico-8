--[[ CELLS.LUA 
	- 
	@date 2025-07-18
	
	FUNCTIONS
	-
]]--

-- TABLES AND VARIABLES

function store_empty_cells(table, max_position, scale)
	for y = 0, max_position-1, scale do
		for x = 0, max_position-1, scale do
			add(table, convert_coordinate_to_index(x, y))
		end
	end
end

function convert_coordinate_to_index(x, y)
	return y * max + x
end

function empty_cells_occupy(table, del_x, del_y)
	del(table, convert_coordinate_to_index(del_x, del_y))
end

function empty_cells_free(table, add_x, add_y)
	add(table, convert_coordinate_to_index(add_x, add_y))
end

// LAST_LINE_CELLS_LUA