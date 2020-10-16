extends Node2D

var cell_x = 0
var cell_y = 0

signal hit
signal bonus1
signal bonus2

var nextbonus = 0
var bonus = 0
var color

onready var button = $TouchScreenButton
onready var sprite = $Sprite
onready var BlackLayer = $BlackLayer
onready var bonusn = $Label

var state

var delta_scale_x
var delta_scale_y

onready var delta_color_a = 0.75/60

onready var max_scale = 70.0/256.0

# Called when the node enters the scene tree for the first time.

func update_texture():
	BlackLayer.set_modulate(Color(0, 0, 0, 1))
	
	if(bonus==0):
		bonusn.hide()
	elif(bonus==1):
		bonusn.set_text("3")
		bonusn.show()
	elif(bonus==2):
		bonusn.set_text("5")
		bonusn.show()
	
	if(color==0):
		sprite.set_modulate(Color(1, 1, 1, 0.7))
	elif(color==1):
		sprite.set_modulate(Color(1, 0.28, 0.10, 0.7))
	elif(color==2):
		sprite.set_modulate(Color(0, 0.6, 0, 0.7))
	elif(color==3):
		sprite.set_modulate(Color(0, 0.36, 90, 0.7))
	
	pass

func _connect(obj):
	connect("hit",obj,"_on_Ball_hit",[cell_x,cell_y])
	connect("bonus1",obj,"_on_Bonus_hit",[1,cell_x,cell_y])
	connect("bonus2",obj,"_on_Bonus_hit",[2,cell_x,cell_y])

func _ready():
	BlackLayer.set_deferred("visible",false)
	delta_scale_x = sprite.get_scale().x/35.0
	delta_scale_y = sprite.get_scale().y/35.0
	state = "alive"
	update_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(state=="fading"):
		if(bonus==0):
			on_state_fading()
		if(bonus==1):
			on_state_fading_bonus1()
		if(bonus==2):
			on_state_fading_bonus2()

	if(state=="respawn"):
		on_state_respawn()
		

##start no bonus
#start fading
func state_pre_fading():
	BlackLayer.set_deferred("visible",true)
	BlackLayer.set_scale(Vector2(0.0,0.0))
	BlackLayer.set_modulate(Color(0, 0, 0, 0.8))
	state = "fading"

func on_state_fading():
	var scale = BlackLayer.get_scale()
	
	if(scale.x<=0.29):
		BlackLayer.position.x = (70.0-(scale.x*256.0))/2
		BlackLayer.position.y = (70.0-(scale.y*256.0))/2
		BlackLayer.set_scale(Vector2(scale.x+delta_scale_x,scale.y+delta_scale_y))
		
	elif(scale.x>=0.29):
		var color = BlackLayer.get_modulate()
		var color_2 = sprite.get_modulate()
		if(color.a>=0.05):
			BlackLayer.set_modulate(Color(0, 0, 0, color.a-delta_color_a))
			sprite.set_modulate(Color(color_2.r,color_2.g,color_2.b,color_2.a-delta_color_a))

		elif(color_2.a<0.05):
			state_after_fading()

func state_after_fading():
	BlackLayer.set_deferred("visible", false)
	state_pre_respawn()
#end fading

#start respawn
func state_pre_respawn():
	sprite.set_scale(Vector2(0.0,0.0))
	
	color = randi()%4
	
	_update_bonus()
	
	update_texture()
	var color = sprite.get_modulate()
	sprite.set_modulate(Color(color.r,color.g,color.b,0))
	state = "respawn"
	pass

func on_state_respawn():
	var scale = sprite.get_scale()
	var color = sprite.get_modulate()
	
	if(scale.x<max_scale):
		sprite.position.x = (70.0-(scale.x*256.0))/2
		sprite.position.y = (70.0-(scale.y*256.0))/2
		sprite.set_scale(Vector2(scale.x+delta_scale_x,scale.y+delta_scale_y))
	
	if(color.a<0.65):
		sprite.set_modulate(Color(color.r,color.g,color.b,color.a+delta_color_a))
	
	if(scale.x>max_scale and color.a>0.65):
		_ready()

#end respawn
##end no bonus

##start bonus small
#start fading
func state_pre_fading_bonus1():
	BlackLayer.set_z_index(1)
	BlackLayer.set_deferred("visible",true)
	BlackLayer.set_scale(Vector2(0.0,0.0))
	BlackLayer.set_modulate(Color(0, 0, 0, 0.95))
	state = "fading"

func on_state_fading_bonus1():
	var scale = BlackLayer.get_scale()
	
	if(scale.x<=1):
		BlackLayer.position.x = (70.0-(scale.x*256.0))/2
		BlackLayer.position.y = (70.0-(scale.y*256.0))/2
		BlackLayer.set_scale(Vector2(scale.x+delta_scale_x*3.4,scale.y+delta_scale_y*3.4))
		if(scale.x>=0.98):
			emit_signal("bonus1")
			bonusn.hide()
		
	elif(scale.x>=1):
		
		var color = BlackLayer.get_modulate()
		var color_2 = sprite.get_modulate()
		if(color.a>=0.03):
			BlackLayer.set_modulate(Color(0, 0, 0, color.a-delta_color_a))
			sprite.set_modulate(Color(color_2.r,color_2.g,color_2.b,color_2.a-delta_color_a))
		elif(color_2.a<0.03):
			state_after_fading()
	
func state_after_fading_bonus1():
	BlackLayer.set_z_index(0)
	BlackLayer.set_deferred("visible", false)
	if(bonus!=0):
		bonus = 0
	state_pre_respawn()

#end fading
##end bonus small

##start bonus medium
#start fading
func state_pre_fading_bonus2():
	BlackLayer.set_z_index(1)
	BlackLayer.set_deferred("visible",true)
	BlackLayer.set_scale(Vector2(0.0,0.0))
	BlackLayer.set_modulate(Color(0, 0, 0, 0.95))
	state = "fading"

func on_state_fading_bonus2():
	var scale = BlackLayer.get_scale()
	
	if(scale.x<=1.48):
		BlackLayer.position.x = (70.0-(scale.x*256.0))/2
		BlackLayer.position.y = (70.0-(scale.y*256.0))/2
		BlackLayer.set_scale(Vector2(scale.x+delta_scale_x*5.4,scale.y+delta_scale_y*5.4))
		if(scale.x>=1.46):
			emit_signal("bonus2")
			bonusn.hide()
		
	elif(scale.x>=1.48):
		
		var color = BlackLayer.get_modulate()
		var color_2 = sprite.get_modulate()
		if(color.a>=0.03):
			BlackLayer.set_modulate(Color(0, 0, 0, color.a-delta_color_a))
			sprite.set_modulate(Color(color_2.r,color_2.g,color_2.b,color_2.a-delta_color_a))
		elif(color_2.a<0.03):
			state_after_fading()
	
func state_after_fading_bonus2():
	BlackLayer.set_z_index(0)
	BlackLayer.set_deferred("visible", false)
	if(bonus!=0):
		bonus = 0
	state_pre_respawn()

#end fading
##end bonus medium

#start respawn
#end respawn
func _update_bonus():
	if(bonus!=0):
		bonus=0
	if(bonus==0 and nextbonus!=0):
		bonus=nextbonus
		nextbonus=0
	
##end bonus small
func _on_TouchScreenButton_pressed():
	if(state=="alive"):
		emit_signal("hit")

func on_death():
	if(bonus==0):
		state_pre_fading()
	if(bonus==1):
		state_pre_fading_bonus1()
	if(bonus==2):
		state_pre_fading_bonus2()
	
	pass # Replace with function body.

