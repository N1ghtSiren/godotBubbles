extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_continue_pressed():
	self.set_deferred("visible",false)
	$"../level".set_deferred("visible",true)
	pass # Replace with function body.


func _on_button_market2_pressed():
	
	pass # Replace with function body.


func _on_button_to_main_menu_pressed():
	self.set_deferred("visible",false)
	$"../main menu".set_deferred("visible",true)
	pass # Replace with function body.
