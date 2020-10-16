extends Node2D

var balls = []

var score = 0
var taps = 0
var combo = 0
var lastcolor = 0

onready var text_score = $text_score
onready var text_combo = $text_combo
onready var text_taps = $text_taps

onready var text_level = $text_level
onready var text_level_desc = $text_level_desc

onready var SoundVelosiped = $"../SoundVelosiped"

var current_level

var score_to_reach
var taplimit

func end_game():
	if(balls.size()>1 and balls[0][0]!=null):
		var a = 0
		var b = 0
		
		while a < 8:
			while b < 16:
				balls[a][b].queue_free()
				b = b + 1
				
			b = 0
			a = a + 1

func reset_vars():
	taplimit = 0
	score_to_reach = 0
	score = 0
	taps = 0
	combo = 0
	lastcolor = 0

func _on_Ball_hit(pos_x, pos_y):
	var clicked_ball = balls[pos_y][pos_x]
	var basecolor = clicked_ball.color
	var pos
	var matched = []
	var stack = []
	var blacklist = []
	var cur_ball
	
	var x
	var y
	
	stack.append([pos_x,pos_y])
	
	while(stack.size()>0):
		pos = stack.pop_front()
		cur_ball = balls[pos[1]][pos[0]]
		
		#check if in blacklist
		if(blacklist.has(cur_ball)):
			#goto may be here
			pass
		else:
			#if same color
			if(cur_ball.color == basecolor):
				matched.append(cur_ball)
				blacklist.append(cur_ball)
			#add nearby cells to check
			x = pos[0]-1
			y = pos[1]
			if(check(y,x) and basecolor==cur_ball.color and cur_ball.state=="alive"):
				stack.append([x,y])
			x = pos[0]+1
			y = pos[1]
			if(check(y,x) and basecolor==cur_ball.color and cur_ball.state=="alive"):
				stack.append([x,y])
			x = pos[0]
			y = pos[1]-1
			if(check(y,x) and basecolor==cur_ball.color and cur_ball.state=="alive"):
				stack.append([x,y])
			x = pos[0]
			y = pos[1]+1
			if(check(y,x) and basecolor==cur_ball.color and cur_ball.state=="alive"):
				stack.append([x,y])
			#end check
			
	var matchcount = matched.size()
	
	#destroy
	for v in matched:
		v.on_death()
	
	SoundVelosiped.play()
	
	#apply score and combo
	var score_last = matchcount*5
	
	if(lastcolor==basecolor):
		combo = combo + 1
	elif(lastcolor!=basecolor):
		lastcolor = basecolor
		combo = 1
	
	#calc bonuses
	var bonustoadd = []
	var i
	
	#per 5
	i = matchcount/5
	while i>0:
		bonustoadd.append(1)
		i = i - 1
	
	#per 10
	i = matchcount/10
	while i>0:
		bonustoadd.append(2)
		i = i - 1
	#combo
	#per 5
	if(combo%5==0):
		i = combo/5
		while i>0:
			bonustoadd.append(1)
			i = i - 1
		#per 10
		i = combo/10
		while i>0:
			bonustoadd.append(1)
			i = i - 1
	
	#apply bonuses
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var matched2 = matched.duplicate(true)
	
	if(bonustoadd.size()>0):
		if(clicked_ball.nextbonus==0):
			clicked_ball.nextbonus=bonustoadd.pop_back()
		
		for ball in matched2:
			if(bonustoadd.size()>0):
				if(ball.nextbonus==0):
					ball.nextbonus=bonustoadd.pop_back()
	
	score_last = score_last*combo
	score += score_last
	taps = taps + 1
	
	if(taps>=taplimit):
		game_over()
	
	#create score text
	var text = preload("res://Text.tscn").instance()
	text.create(str(score_last),2,clicked_ball.position.x,clicked_ball.position.y)
	add_child(text, true)
	
	#update text on screen
	update_text(score,score_last,combo,taps)
	
	pass # Replace with function body.

func check(y,x):
	if(y>=0 and y<8 and x>=0 and x<16):
		return true
	return false

func check2(y,x):
	if(y>=0 and y<8 and x>=0 and x<16):
		if(balls[y][x].state=="alive"):
			return true
		
	return false

func _on_Bonus_hit(bonus,pos_x,pos_y):
	var matched = get_bonus_area(bonus,pos_x,pos_y)
	var count = matched.size()
	var clicked_ball = balls[pos_y][pos_x]
	
	for v in matched:
		v.on_death()
	
	SoundVelosiped.play()
	
	var score_last = 10 * count
	
	var text = preload("res://Text.tscn").instance()
	text.create(str(score_last),2,clicked_ball.position.x,clicked_ball.position.y-40)
	add_child(text, true)
	
	score += score_last
	
	update_text(score,score_last,combo,taps)
	pass
	

func get_bonus_area(bonus,x,y):
	var t
	var matched = []
	
	if(bonus==1):
		t = [ [y-1,x-1], [y-1,x], [y-1,x+1],
			  [y,  x-1],          [y,  x+1],
			  [y+1,x-1], [y+1,x], [y+1,x+1]
		]
		
		for c in t :
			if(check2(c[0],c[1])):
				matched.append(balls[c[0]][c[1]])
			
		
	if(bonus==2):
		t = [              [y-2,x-1], [y-2,x], [y-2,x+1],
				[y-1,x-2], [y-1,x-1], [y-1,x], [y-1,x+1], [y-1,x+2],
				[y,x-2],   [y,x-1],            [y,x+1],   [y,x+2],
				[y+1,x-2], [y+1,x-1], [y+1,x], [y+1,x+1], [y+1,x+2],
						   [y+2,x-1], [y+2,x], [y+2,x+1]
		]
		
		for c in t :
			if(check2(c[0],c[1])):
				matched.append(balls[c[0]][c[1]])
			
		
	return matched

func show_text():
	text_level_desc.set_deferred("visible",false)
	text_level.set_deferred("visible",false)
	$text_to_main_menu.set_deferred("visible",false)
	$text_try_again.set_deferred("visible",false)
	$text_next_level.set_deferred("visible",false)
	$button_next_level.set_deferred("visible",false)
	$button_to_menu.set_deferred("visible",false)
	$button_try_again.set_deferred("visible",false)
	
	$button_menu.set_deferred("visible",true)
	$text_menu.set_deferred("visible",true)
	$text_score.set_deferred("visible",true)
	$text_combo.set_deferred("visible",true)
	$text_taps.set_deferred("visible",true)

func hide_text():
	text_level_desc.set_deferred("visible",true)
	text_level.set_deferred("visible",true)
	$text_to_main_menu.set_deferred("visible",true)
	$text_try_again.set_deferred("visible",true)
	$text_next_level.set_deferred("visible",true)
	$button_next_level.set_deferred("visible",true)
	$button_to_menu.set_deferred("visible",true)
	$button_try_again.set_deferred("visible",true)
	
	$button_menu.set_deferred("visible",false)
	$text_menu.set_deferred("visible",false)
	$text_score.set_deferred("visible",false)
	$text_combo.set_deferred("visible",false)
	$text_taps.set_deferred("visible",false)

func prepare_level(level_number):
	reset_vars()
	end_game()
	show_text()
	
	current_level = level_number
	var req = Levels_db.get(level_number)
	taplimit = req[0]
	score_to_reach = req[1]
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	rng.set_seed(rng.randi_range(1,16))
	var ball
	
	var x = 0
	var y = 0
	
	while y<8:
		balls.append([])
		balls[y] = []
		
		while x<16:
			balls[y].append([])
			
			ball = preload("res://ball.tscn").instance()
			
			ball.cell_y = y
			ball.cell_x = x
			
			ball._connect(self)
			
			add_child(ball, true)
			
			ball.position.y = 80*y+5
			ball.position.x = 80*x+5
			
			balls[y][x] = ball
			
			ball.color = rng.randi_range(0,3)
			ball.update_texture()
			x = x + 1
			
		y = y + 1
		x = 0

func game_over():
	hide_text()
	
	if(score>=score_to_reach):
		Globals.show_bg()
		Globals.lvl_set_completed(current_level)
		
		text_level.set_text("Level "+str(current_level)+" completed")
		text_level_desc.set_text("Target: "+str(score_to_reach)+" in "+str(taplimit)+" taps \nReached: "+str(score)+" in "+str(taplimit)+" taps")
		end_game()
	else:
		Globals.show_bg()
		
		text_level.set_text("Level "+str(current_level)+" failed")
		text_level_desc.set_text("Target: "+str(score_to_reach)+" in "+str(taplimit)+" taps \nReached: "+str(score)+" in "+str(taplimit)+" taps \nHint: abuse combo to reach that! \nGather combo on alone ones\nThen pop groups, get bonuses and clear screen!")
		end_game()

func update_text(score,score_last,combo,taps):
	text_score.set_text("Score: "+str(score)+" +"+str(score_last))
	text_combo.set_text("Combo: "+str(combo))
	text_taps.set_text("Taps: "+str(taps))

func _on_button_menu_pressed():
	self.set_deferred("visible",false)
	$"../pause menu".set_deferred("visible",true)
	Globals.show_bg()
	pass # Replace with function body.

func _on_button_try_again_pressed():
	prepare_level(current_level)
	Globals.hide_bg()
	pass # Replace with function body.

func _on_button_to_menu_pressed():
	end_game()
	self.set_deferred("visible",false)
	$"../main menu".set_deferred("visible",true)


func _on_button_next_level_pressed():
	if(current_level<50):
		Globals.hide_bg()
		prepare_level(current_level+1)
	else:
		return
