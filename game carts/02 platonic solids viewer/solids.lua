--[[ SOLIDS.LUA
	@author Kardo Rostam
	@date 2025-09-26
]]--

-- Calculated the golden ratio
phi = (1 + sqrt(5)) / 2

solids = {
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
		v = {
			{ 1, 0, 0}, {-1, 0, 0}, { 0, 1, 0},
			{ 0,-1, 0}, { 0, 0, 1}, { 0, 0,-1}
		},
		e = { -- connects to all except its opposite
			{1,3}, {1,4}, {1,5}, {1,6},
			{2,3}, {2,4}, {2,5}, {2,6},
			{3,5}, {3,6}, {4,5}, {4,6}
		}
	},
	{	name="dodecahedron", dice="d12", color=11,
		v = { -- 20 vertices
			-- 8 cube corners
			{-1,-1,-1},{-1,-1, 1},{-1, 1,-1},{-1, 1, 1},
			{ 1,-1,-1},{ 1,-1, 1},{ 1, 1,-1},{ 1, 1, 1},
			-- 12 golden ratio points
			{0,-1/phi,-phi},{0,-1/phi,phi},{0,1/phi,-phi},{0,1/phi,phi},
			{-1/phi,-phi,0},{-1/phi,phi,0},{1/phi,-phi,0},{1/phi,phi,0},
			{-phi,0,-1/phi},{phi,0,-1/phi},{-phi,0,1/phi},{phi,0,1/phi}
		},
		e = {
		},
		
	},
	{name="icosahedron", dice="d20", color=12},
}

function solids.init()
end









