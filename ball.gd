extends Node2D

var cell_x = 0
var cell_y = 0

signal hit

var bonus
var color

var texture_bonus_small = preload("res://things/texture_bonus_small.png")

onready var DeathTimer = $DeathTimer
onready var button = $TouchScreenButton
onready var sprite = $Sprite

var state

var delta_scale_x
var delta_scale_y

onready var max_scale = 70.0/210.0

# Called when the node enters the scene tree for the first time.

func update_texture():
	if(bonus==1):
		sprite.set_texture(texture_bonus_small)
	
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

func _ready():
	button.set_scale(Vector2(max_scale,max_scale))
	sprite.set_scale(Vector2(max_scale,max_scale))
	delta_scale_x = sprite.get_scale().x/60.0
	delta_scale_y = sprite.get_scale().y/60.0
	state = "alive"
	update_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(state=="fading"):
		var scale = sprite.get_scale()
		if(scale.x>=0):
			sprite.set_scale(Vector2(scale.x-delta_scale_x,scale.y-delta_scale_y))

	if(state=="respawn"):
		var scale = sprite.get_scale()
		if(scale.x<max_scale):
			sprite.set_scale(Vector2(scale.x+delta_scale_x,scale.y+delta_scale_y))
		elif(scale.x>=max_scale):
			_ready()
			
	if(state=="bonus_small"):
		var scale  = sprite.get_scale()
		if(scale.x<max_scale*2):
			sprite.set_scale(Vector2(scale.x+delta_scale_x,scale.y+delta_scale_y))
		elif(scale.x>=max_scale*3):
			_ready()

func _on_TouchScreenButton_pressed():
	if(state=="alive"):
		
		if(bonus==1):
			on_bonus()
			return
		
		emit_signal("hit")

func on_bonus():
	if(bonus==1):
		bonus = 0
		update_texture()
		state=="bonus_small"

func on_death():
	if(state!="bonus_small"):
		DeathTimer.start()
		state = "fading"
	pass # Replace with function body.

func _on_DeathTimer_timeout():
	color = randi()%4
	update_texture()
	state = "respawn"
	pass # Replace with function body.
