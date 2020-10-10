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
			
			#ball.color = randi()%4
			
			balls[a].append([])
			balls[a][b] = ball
			
			ball._connect(self)
			
			add_child(ball, true)
			
			ball.position.y = 80*a+5
			ball.position.x = 80*b+5
			b = b + 1
			
		b = 0
		a = a + 1
	balls[5][5].bonus = 1
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
			if(check(x,y) and basecolor==cur_ball.color and cur_ball.state=="alive"):
				stack.append([x,y])
			x = pos[0]+1
			y = pos[1]
			if(check(x,y) and basecolor==cur_ball.color and cur_ball.state=="alive"):
				stack.append([x,y])
			x = pos[0]
			y = pos[1]-1
			if(check(x,y) and basecolor==cur_ball.color and cur_ball.state=="alive"):
				stack.append([x,y])
			x = pos[0]
			y = pos[1]+1
			if(check(x,y) and basecolor==cur_ball.color and cur_ball.state=="alive"):
				stack.append([x,y])
			#end check
			
			
			
		
	var count = matched.size()
	print(count)
	
	for v in matched:
		v.on_death()
	
	var score_last = count*5
	
	if(lastcolor==basecolor):
		combo = combo + 1
	elif(lastcolor!=basecolor):
		lastcolor = basecolor
		combo = 1
	
	score_last = score_last*combo
	
	var text = preload("res://Text.tscn").instance()
	text.create(str(score_last),2,clicked_ball.position.x,clicked_ball.position.y)
	add_child(text, true)
	
	score += score_last
	
	taps = taps + 1
	text_score.set_text("Score: "+str(score)+"  +"+str(score_last))
	text_combo.set_text("Combo: "+str(combo))
	text_taps.set_text("Taps: "+str(taps))
	
	pass # Replace with function body.
	

func check(x,y):
	if(y>=0 and y<8 and x>=0 and x<16):
		return true
	return false
	
func prepare_level():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	rng.set_seed(rng.randi_range(1,16))
	print(Globals)
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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_menu_pressed():
	self.set_deferred("visible",false)
	$"../pause menu".set_deferred("visible",true)
	pass # Replace with function body.
