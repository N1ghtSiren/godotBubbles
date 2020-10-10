extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var button
	
	var n = 1
	
	var a = 1
	
	var b = 1
	
	while(b<6):
		while(a<11):
			button = preload("res://level_button.tscn").instance()
			
			button.position.x = 128*(a-1)
			button.position.y = 128*(b-1)
			button.prepare(str(n),n,self)
			add_child(button, true)
			
			a = a + 1
			n = n + 1
		
		b = b + 1
		a = 1
	pass # Replace with function body.

func on_tap(n):
	self.set_deferred("visible",false)
	$"../level".set_deferred("visible",true)
	$"../level".prepare_level()
	print(str(n))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
