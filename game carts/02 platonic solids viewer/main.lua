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

-- vertices
cube = {-- Front: -1, Back: +1
	{-1,-1,-1}, {1,-1,-1}, {1,1,-1}, {-1,1,-1},
	{-1,-1, 1}, {1,-1, 1}, {1,1, 1}, {-1,1, 1}
}

-- edges

function _init()
	-- TODO Make the scale adjustable
	center_x = 64
	center_y = 64
	color = 7
end

function _update()
end

function _draw()
	cls()
	
	for i = 1, #cube do
		vertices = cube[i]
		pointX = vertices[1] + center_x
		pointY = vertices[2] + center_y
		--skip Z for now
		
		pset(pointX, pointY, color)
	end
end

-- LAST_LINE_MAIN_LUA