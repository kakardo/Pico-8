--[[ SCORE.LUA 
	@date 2025-10-26
]]--
score = 0
hiscore = {0, 0, 0, 0, 0}
time_played = {0, 0, 0, 0, 0}
score_saved = false

function init_score()
  cartdata("kardo_snake")
	load_score()
end

function load_score()
	for i = 1, 5 do
		hiscore[i]     = dget(i - 1) or 0
		time_played[i] = dget(4 + i) or 0
	end
end

function save_score()
	for i = 1, 5 do
		dset(i - 1, hiscore    [i])
		dset(4 + i, time_played[i])
	end
end

function submite_score(new_score)
	local new_time = flr(cycle_cnt/60)

	for i = 1, 5 do
		local score_i = hiscore[i]
		local time_i = time_played[i]
		
		-- Is better if high score, or same but shorter time
		local better = (new_score > score_i) or
						(new_score == score_i and new_time < time_i)

		-- Shifting arrays to make room for new high score
		if better then
			for j = 5, i + 1, -1 do
				hiscore[j] = hiscore[j-1]
				time_played[j] = time_played[j-1]
			end
		
		end
		
		hiscore[i] = new_score
		time_played[i] = new_time
		save_score()
		return
	end
end

-- LAST_LINE_OF_SCORE_LUA