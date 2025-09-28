--[[ UI.LUA
	@author Kardo Rostam
	@date 2025-09-28
]]--

ui = {
	 centered_txt = function(txt, y_pos, txt_color)
		x_pos = 64 - #txt * 2 
		print(txt, x_pos, y_pos, txt_color)
	end,

	print_menu = function(shape, x, y, z)
		dice_label = shape.dice
		color = shape.color

		-- CONVERT LONG TEXT TO VARIABLES
		x = "X= "..ceil(x * 1000)
		y = "Y= "..ceil(y * 1000)
		z = "Z= "..ceil(z * 1000)

		-- HIGHLIGHT CHOSEN OPTION
		if selected == 0 then
			dice_label = "<"..dice_label..">"
			x = " "..x.." "
			y = " "..y.." "
			z = " "..z.." "
		elseif selected == 1 then
			dice_label = " "..dice_label.." "
			x = "<"..x..">"
			y = " "..y.." "
			z = " "..z.." "
		elseif selected == 2 then
			dice_label = " "..dice_label.." "
			x = " "..x.." "
			y = "<"..y..">"
			z = " "..z.." "
		else
			dice_label = " "..dice_label.." "
			x = " "..x.." "
			y = " "..y.." "
			z = "<"..z..">"
		end
		
		-- OPTION MENU
		options = dice_label.." "..x.." "..y.." "..z
		ui.centered_txt(shape.name, 0, color)
		ui.centered_txt(options, 7, color)
		ui.centered_txt("⬅️/➡️ switch parameters", 116, color)
		ui.centered_txt("⬆️/⬇️ adjust angle", 123, color)
	end
}