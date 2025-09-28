--[[ UI.LUA
	@author Kardo Rostam
	@date 2025-09-28
]]--


ui = {
	 centered_txt = function(txt, y_pos, txt_color)
		x_pos = 64 - #txt * 2 
		print(txt, x_pos, y_pos, txt_color)
	end
}