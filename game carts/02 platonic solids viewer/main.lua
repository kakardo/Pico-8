--[[ MAIN.LUA
	- Main loop of the program.
	@author Kardo Rostam
	@date 2025-09-15
		
	https://en.wikipedia.org/wiki/Platonic_solid
	https://en.wikipedia.org/wiki/3D_projection
	https://en.wikipedia.org/wiki/Orthographic_projection
	https://en.wikipedia.org/wiki/Perspective_(graphical)

	TODO
	- Implement the five platonic solids:
		Regular tetrahedron
		Cube
		Regular octahedron 
		Regular dodecahedron
		Regular icosahedron 
	- Implement two perspective:
		Orthographic (ignores depth)
		Perspective
	
Notes for MD-doc
Linear algebra's needed for matrix calculations.
Cube has 8 corners (vertices).

]]--

-- vertices (8 in a cube)
cube = { -- Front: -1, Back: +1
	{-1,-1,-1}, {1,-1,-1}, {1,1,-1}, {-1,1,-1},
	{-1,-1, 1}, {1,-1, 1}, {1,1, 1}, {-1,1, 1}
}

edges = { -- (12 in a cube)
  {1,2}, {2,3}, {3,4}, {4,1}, -- back
  {5,6}, {6,7}, {7,8}, {8,5}, -- front
  {1,5}, {2,6}, {3,7}, {4,8}  -- bridges
}

function calc_projection(coordinate, scale, center)
	return coordinate * scale + center
end

function _init()
	center_x = 64
	center_y = 64
	color = 7
	scale = 20
end

function _update()
end

function _draw()
	cls()
	
	for i = 1, #cube do
		local vertices = cube[i]
		
		-- sin() and cos() angles go from 0 to 360° (0.0 to 1.0)
		-- example -> 0.25 = 90°, 1.0 = 360°)
		angle = 0.1
		rotX = vertices[1] * cos(angle) - vertices[3] * sin(angle)

		pointX = calc_projection(rotX, scale, center_x)
		pointY = calc_projection(vertices[2], scale, center_y)
		--skip Z for now
		
		pset(pointX, pointY, color)
	end
end

-- LAST_LINE_MAIN_LUA