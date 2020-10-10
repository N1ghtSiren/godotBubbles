extends Node2D

var lifetime = 0
var transparency = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	lifetime -= delta
	transparency -= delta/2.0
	
	if(lifetime<=0):
		queue_free()
		
	set_modulate(Color(1, 1, 1, transparency))
	

func create(text,lifetime_arg,pos_x,pos_y):
	lifetime = lifetime_arg
	$Label.set_text("+"+text)
	position.x = pos_x
	position.y = pos_y
