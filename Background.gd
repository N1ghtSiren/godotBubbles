extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var ball
	
	var i = 0
	while i<50:
		
		ball = preload("res://ball_bg.tscn").instance()
		ball.conf(rng.randf_range(0.05,0.1),rng.randf_range(0.25,0.3),rng.randf_range(0.01,0.03),rng.randf_range(0.1,1.0),rng.randf_range(0.1,1.0),rng.randf_range(0.1,1.0),0.7)
		
		ball.position.x = rng.randi_range(0,1280)
		ball.position.y = rng.randi_range(0,720)
		add_child(ball, true)
		
		
		i = i + 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
