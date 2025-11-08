--[[ SCORE.LUA 
	@date 2025-10-26
]]--
score = 0
hiscore = {0, 0, 0, 0, 0}
score_saved = false

function init_score()
  cartdata("kardo_snake")
	load_score()
end

function load_score()
	for i = 1, 5 do
		hiscore[i] = dget(i-1) or 0
	end
end

function save_score()
	for i = 1, 5 do
		dset(i-1, hiscore[i])
	end
end

function submite_score(new_score)
	for i = 1, 5 do
		if new_score > hiscore[i] then
			for j = 5, i+1, -1 do
				hiscore[j] = hiscore[j-1]
			end
			hiscore[i] = new_score
			save_score()
			return
		end
	end
end

-- LAST_LINE_OF_SCORE_LUA