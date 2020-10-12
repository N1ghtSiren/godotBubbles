extends Node2D


var min_scale
var max_scale
var delta_scale
var cur_scale

var scale_flag = false

onready var sprite = $sprite

func conf(min_,max_,delta,c_r,c_g,c_b,c_a):
	min_scale = min_
	max_scale = max_
	cur_scale = min_
	delta_scale = delta
	$sprite.set_modulate(Color(c_r,c_g,c_b,c_a))

func _process(delta):
	if(cur_scale>max_scale):
		scale_flag = false
	elif(cur_scale<min_scale):
		scale_flag = true
		
	if(scale_flag==true):
		cur_scale = cur_scale + delta_scale/30.0
	elif(scale_flag==false):
		cur_scale = cur_scale - delta_scale/30.0
	
	sprite.set_scale(Vector2(cur_scale,cur_scale))
