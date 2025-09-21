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
vertices = { -- Front: -1, Back: +1
	{-1,-1,-1}, {1,-1,-1}, {1,1,-1}, {-1,1,-1},
	{-1,-1, 1}, {1,-1, 1}, {1,1, 1}, {-1,1, 1}
}

edges = { -- (12 in a cube)
  {1,2}, {2,3}, {3,4}, {4,1}, -- back
  {5,6}, {6,7}, {7,8}, {8,5}, -- front
  {1,5}, {2,6}, {3,7}, {4,8}  -- bridges
}

function calc_projection(x, y)
	return x * scale + center_x, y * scale + center_y
end

function calc_rotation(x, y)
end

function rotate_x()
end

function _init()
	center_x = 64
	center_y = 64
	color = 7
	scale = 20
	
	angle = 0.1
end

function _update()
	angle += 0.01
end

function _draw()
	cls()
	
	for e in all(edges) do
		alfa = vertices[e[1]]
		beta = vertices[e[2]]
	
		-- sin() and cos() angles go from 0 to 360° (0.0 to 1.0)
		-- example -> 0.25 = 90°, 1.0 = 360°)
		rotX1 = alfa[1] * cos(angle) - alfa[3] * sin(angle)
		rotX2 = beta[1] * cos(angle) - beta[3] * sin(angle)



		pointX1, pointY1 = calc_projection(rotX1, alfa[2])
		pointX2, pointY2 = calc_projection(rotX2, beta[2])

		line(pointX1, pointY1, pointX2, pointY2, 7)
		--pset(pointX, pointY, color)
	end
end

-- LAST_LINE_MAIN_LUA