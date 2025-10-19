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
  local first = 20
  print_centered("hiscore", 64, 80, 137)
  print("1st ", first, 85, 137)
  --print("88     88", first+12, 85, 8) -- space check
  print(hiscore[1], first+28, 85, 137)
  print("gelaflax", first+48, 85, 137) -- space check

  print_centered("2nd "..hiscore[2], 64, 96, 137)
  print_centered("3rd "..hiscore[3], 64, 104, 137)
end

function print_score()
end

-- LAST_LINE_OF_UI_LUA