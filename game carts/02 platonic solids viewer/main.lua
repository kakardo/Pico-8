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



--[[ ROTATION - - - - - - - - - - ]]--
-- sin() and cos() angles go from 0 to 360° (0.0 to 1.0)
-- example -> 0.25 = 90°, 1.0 = 360°)
function calc_rotation(x, y, z)
	return rotate_x(x, y, z, angle_x)
end

function rotate_x(x, y, z, angle)
	return 	x * cos(angle) - z * sin(angle),
			x * sin(angle) + y * cos(angle),
			z
end

--[[ MAIN - - - - - - - - - - - - ]]--
function _init()
	center_x = 64
	center_y = 64
	color = 7
	scale = 20
	
	angle_x = 0.1
end

function _update()
	angle_x += 0.01
end

function _draw()
	cls()
	
	for e in all(edges) do
		alfa = vertices[e[1]]
		beta = vertices[e[2]]
	
		ax, ay, az = calc_rotation(alfa[1], alfa[2], alfa[3])
		bx, by, bz = calc_rotation(beta[1], beta[2], beta[3])

		pointX1, pointY1 = calc_projection(ax, ay)
		pointX2, pointY2 = calc_projection(bx, by)

		line(pointX1, pointY1, pointX2, pointY2, 7)
	end
end

-- LAST_LINE_MAIN_LUA