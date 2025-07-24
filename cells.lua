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
			table[convert_coordinate_to_index(x, y)] = false
		end
	end
end

function convert_coordinate_to_index(x, y)
	return y * max + x
end

function empty_cells_occupy(table, del_x, del_y)
	table[convert_coordinate_to_index(del_x, del_y)] = true
end

function empty_cells_free(table, add_x, add_y)
	table[convert_coordinate_to_index(add_x, add_y)] = false
end

function is_occupied(table, x, y)
	if table[convert_coordinate_to_index(x, y)] then
		return true
	else
		return false
	end
end

// LAST_LINE_CELLS_LUA