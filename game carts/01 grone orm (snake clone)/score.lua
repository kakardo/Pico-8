--[[ SCORE.LUA 
	@date 2025-10-26

	Memory array:
	0,1,2,3,4 = top five scores
	5,6,7,8,9 = top five times
	10 = total score
	11 = total time
]]--

score = 0
hiscore = {0, 0, 0, 0, 0}
time_played = {0, 0, 0, 0, 0}
player = {"unknown", "unknown", "unknown", "unknown", "unknown"}
total_score = 0
total_time = 0 -- seconds
score_saved = false

function init_score()
  cartdata("kardo_snake")
	load_score()
	load_totals()
end

function load_score()
	for i = 1, 5 do
		hiscore[i]     = dget(i - 1) or 0
		time_played[i] = dget(4 + i) or 0
	end
end

function load_totals()
	total_score = dget(10) or 0
	total_time  = dget(11) or 0
end

function save_score()
	for i = 1, 5 do
		dset(i - 1, hiscore    [i])
		dset(4 + i, time_played[i])
	end
end

function save_totals()
	dset(10, total_score)
	dset(11, total_time)
end

function record_run(score, sec)
	total_score += score
	total_time += sec
	save_totals()
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
		
			hiscore[i] = new_score
			time_played[i] = new_time
			save_score()
			return
		end
	end
end

-- LAST_LINE_OF_SCORE_LUA