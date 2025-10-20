--[[ UI.LUA 
	@date 2025-10-12
	
	FUNCTIONS

]]--

function print_ui()
  print_centered("score: "..score, 32, 24, 9)
  print_centered("length: "..body.segments+1, 96, 24, 11)
  print_centered("game over", 64, 48, 8)
  print_centered("< press 🅾️ or \'z\' to retry >", 64, 56, 6)
  --print_centered("adjust starting speed",64,88,5)

  -- Letter (with space) = 4 pixels
  local score_x = 28
  local score_y = 77
  
  local score_color = 137
  print_centered("hiscore", 64, score_y, score_color)

  print_score("1st", hiscore[1], score_x, score_y+4, score_color, "kakardo")
  print_score("2nd", hiscore[2], score_x, score_y+11, score_color, "unknown")
  print_score("3rd", hiscore[3], score_x, score_y+18, score_color, "unknown")
  print_score("4rd", hiscore[4], score_x, score_y+25, score_color, "unknown")
  print_score("5rd", hiscore[5], score_x, score_y+32, score_color, "unknown")
end

function print_score(place, score, x, y, color, name)
  print(place, x, y, color)
  --print("88     88", x+12, y, 8) -- space check
  print(score, x+28, y, color)
  print(name, x+48, y, color) -- space check
end

-- LAST_LINE_OF_UI_LUA