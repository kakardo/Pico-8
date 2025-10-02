--[[ SOLIDS.LUA
	@author Kardo Rostam
	@date 2025-09-26
	
	Need to be initiated with init() for D12 to work.
	init() uses phi to create golden ratio points for D12.
]]--

solids = {
	init = function()
		-- Calculated the golden ratio
		phi = (1 + sqrt(5)) / 2
		
		-- Contruct vertices for D12 with phi
		solids[4].v = {
			-- 8 cube corners
			{-1,-1,-1},{-1,-1, 1},{-1, 1,-1},{-1, 1, 1},
			{ 1,-1,-1},{ 1,-1, 1},{ 1, 1,-1},{ 1, 1, 1},
			-- 12 golden ratio points
			{0,-1/phi,-phi},{0,-1/phi,phi},{0,1/phi,-phi},{0,1/phi,phi},
			{-1/phi,-phi,0},{-1/phi,phi,0},{1/phi,-phi,0},{1/phi,phi,0},
			{-phi,0,-1/phi},{phi,0,-1/phi},{-phi,0,1/phi},{phi,0,1/phi}
		}
		
		solids[5].v = {
			-- 12 golden ratio points
			{ 0, 1, phi},{ 0,-1, phi},{ 0, 1,-phi},{ 0,-1,-phi},
			{ 1, phi, 0},{-1, phi, 0},{ 1,-phi, 0},{-1,-phi, 0},
			{ phi, 0, 1},{ phi, 0,-1},{-phi, 0, 1},{-phi, 0,-1}
		}
		
		for i = 1, #solids do
			if solids[i].v > 0 and #solids[i].v > 0 then
				local largest_distance = 0
				
				for v in all(solids[i].v) do
					-- Distance of vertex from origin
					local r = sqrt(v[1]^2+v[2]^2+v[3]^2)
					
					-- Save the largest found distance
					if r > largest_distance then
						largest_distance = r
					end
				end
				
				
				
				
				
			end
		end
	end,

	{
		name="tetrahedron", dice="d4", color=8,
		v = { -- 4 vertices
			{ 1, 1, 1}, {-1,-1, 1},
			{-1, 1,-1},	{ 1,-1,-1}
		},
		e = { -- 6 edges
			{1,2}, {1,3}, {1,4},
			{2,3}, {2,4}, {3,4}
		}
	},
	{
		name="cube", dice="d6", color=9,
		v = { -- vertices (8 in a cube) Front: -1, Back: +1
			{-1,-1,-1}, {1,-1,-1}, {1,1,-1}, {-1,1,-1},
			{-1,-1, 1}, {1,-1, 1}, {1,1, 1}, {-1,1, 1}
		},
		e = { -- (12 edges in a cube)
			{1,2}, {2,3}, {3,4}, {4,1}, -- back
			{5,6}, {6,7}, {7,8}, {8,5}, -- front
			{1,5}, {2,6}, {3,7}, {4,8}  -- bridges
		}
	},
	{
		name="octahedron", dice="d8", color=10,
		v = { -- 6 vertices
			{ 1, 0, 0}, {-1, 0, 0}, { 0, 1, 0},
			{ 0,-1, 0}, { 0, 0, 1}, { 0, 0,-1}
		},
		e = { -- 12 edges connects to all except its opposite
			{1,3}, {1,4}, {1,5}, {1,6},
			{2,3}, {2,4}, {2,5}, {2,6},
			{3,5}, {3,6}, {4,5}, {4,6}
		}
	},
	{
		name="dodecahedron", dice="d12", color=11,
		v = {-- 20 vertices need to be built in init()			
		},
		e = { -- 30 edges
			{ 1, 9},{ 1,13},{ 1,17},
			{ 2,10},{ 2,13},{ 2,19},
			{ 3,11},{ 3,14},{ 3,17},
			{ 4,12},{ 4,14},{ 4,19},
			{ 5, 9},{ 5,15},{ 5,18},
			{ 6,10},{ 6,15},{ 6,20},
			{ 7,11},{ 7,16},{ 7,18},
			{ 8,12},{ 8,16},{ 8,20},
			{ 9,11},{10,12},
			{13,15},{14,16},
			{17,19},{18,20},
		},
		
	},
	{
		name="icosahedron", dice="d20", color=12,
		v = {-- 12 vertices need to be built in init()
		},
		e = { -- 30 edges
			{ 1, 2},{ 1, 5},{ 1, 6},{ 1, 9},{ 1,11},
			{ 2, 7},{ 2, 8},{ 2, 9},{ 2,11},
			{ 3, 4},{ 3, 5},{ 3, 6},{ 3,10},{ 3,12},
			{ 4, 7},{ 4, 8},{ 4,10},{ 4,12},
			{ 5, 6},{ 5, 9},{ 5,10},
			{ 6,11},{ 6,12},
			{ 7, 8},{ 7, 9},{ 7,10},
			{ 8,11},{ 8,12},
			{ 9,10},
			{11,12},
		},
	},
}









