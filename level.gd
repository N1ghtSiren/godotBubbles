extends Node2D

var balls = []

var score = 0
var taps = 0
var combo = 0
var lastcolor = 0

onready var text_score = $text_score
onready var text_combo = $text_combo
onready var text_taps = $text_taps

# Called when the node enters the scene tree for the first time.
func _ready():
	var a = 0
	var b = 0
	
	var ball
	
	while a < 8:
		
		balls.append([])
		balls[a] = []
		
		while b < 16:
			
			ball = preload("res://ball.tscn").instance()
			
			ball.cell_y = a
			ball.cell_x = b
			
			balls[a].append([])
			balls[a][b] = ball
			
			ball._connect(self)
			
			add_child(ball, true)
			
			ball.position.y = 80*a+5
			ball.position.x = 80*b+5
			b = b + 1
			
		b = 0
		a = a + 1
	balls[5][5].bonus = 2
pass

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
	
	#calc bonuses
	var bonustoadd = []
	var count = 0
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
	#per 15
	
	#per combo (?)
	
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
	
	
	#destroy
	for v in matched:
		v.on_death()
	
	#apply score and combo
	var score_last = matchcount*5
	
	if(lastcolor==basecolor):
		combo = combo + 1
	elif(lastcolor!=basecolor):
		lastcolor = basecolor
		combo = 1
	
	score_last = score_last*combo
	score += score_last
	taps = taps + 1
	
	#create score text
	var text = preload("res://Text.tscn").instance()
	text.create(str(score_last),2,clicked_ball.position.x,clicked_ball.position.y)
	add_child(text, true)
	
	#update text on screen
	text_score.set_text("Score: "+str(score)+"  +"+str(score_last))
	text_combo.set_text("Combo: "+str(combo))
	text_taps.set_text("Taps: "+str(taps))
	
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
		
	
	var score_last = 10 * count
	
	var text = preload("res://Text.tscn").instance()
	text.create(str(score_last),2,clicked_ball.position.x,clicked_ball.position.y-40)
	add_child(text, true)
	
	score += score_last
	taps = taps + 1
	
	text_score.set_text("Score: "+str(score)+"  +"+str(score_last))
	text_combo.set_text("Combo: "+str(combo))
	text_taps.set_text("Taps: "+str(taps))
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

func prepare_level():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	rng.set_seed(rng.randi_range(1,16))
	var ball
	
	var x = 0
	var y = 0
	
	while y<8:
		while x<16:
			ball = balls[y][x]
			ball.color = rng.randi_range(0,3)
			ball.update_texture()
			x = x + 1
		y = y + 1
		x = 0


#func _process(delta):
#	pass


func _on_button_menu_pressed():
	self.set_deferred("visible",false)
	$"../pause menu".set_deferred("visible",true)
	Globals.show_bg()
	pass # Replace with function body.
