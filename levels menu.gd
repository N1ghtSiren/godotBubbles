extends Node2D

var selected_level = 0

onready var level = $text_level
onready var desc = $text_level_desc

var buttons = []

# Called when the node enters the scene tree for the first time.

func _ready():
	var button
	
	var n = 1
	
	var a = 1
	
	var b = 1
	
	while(b<6):
		buttons.append([])
		buttons[b-1] = []
		
		while(a<11):
			
			buttons[b-1].append([])
			
			
			button = preload("res://level_button.tscn").instance()
			
			button.position.x = 128*(a-1)
			button.position.y = 128*(b-1)
			button.prepare(str(n),n,self)
			
			add_child(button, true)
			buttons[b-1][a-1] = button
			
			a = a + 1
			n = n + 1
		
		b = b + 1
		a = 1
	
	level.set_deferred("visible",false)
	desc.set_deferred("visible",false)
	pass # Replace with function body.

func hide_all():
	var a = 0
	var b = 0
	while(b<5):
		while(a<10):
			buttons[b][a].set_deferred("visible",false)
			a = a + 1
		b = b + 1
		a = 0
	level.set_deferred("visible",true)
	desc.set_deferred("visible",true)

func show_all():
	var a = 0
	var b = 0
	while(b<5):
		while(a<10):
			buttons[b][a].set_deferred("visible",true)
			a = a + 1
		b = b + 1
		a = 0
	level.set_deferred("visible",false)
	desc.set_deferred("visible",false)

func update_all():
	var a = 0
	var b = 0
	while(b<5):
		while(a<10):
			buttons[b][a].update()
			a = a + 1
		b = b + 1
		a = 0

func on_tap(n):
	selected_level = n
	
	level.set_text("Level "+str(n))
	var req = Levels_db.get(n)
	desc.set_text("Achieve "+str(req[1])+" points in "+str(req[0])+" taps")
	
	hide_all()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_start_levels_menu_pressed():
	if(selected_level==0):
		return
	show_all()
	self.set_deferred("visible",false)
	$"../level".set_deferred("visible",true)
	$"../level".prepare_level(selected_level)
	Globals.hide_bg()
	pass # Replace with function body.


func _on_button_back_levels_menu_pressed():
	if(selected_level==0):
		$"..".asdf()
	else:
		show_all()
		selected_level = 0
