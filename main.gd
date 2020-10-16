extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Globals.background = $Background
	
	$"levels menu".hide()
	$"level".hide()
	$"pause menu".hide()
	$"settings menu".hide()
	$"thanks to menu".hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_play_main_menu_pressed():
	$"main menu".set_deferred("visible",false)
	$"levels menu".set_deferred("visible",true)
	$"levels menu".update_all()
	pass

func _on_button_settings_main_menu_pressed():
	$"main menu".set_deferred("visible",false)
	$"settings menu".set_deferred("visible",true)
	pass # Replace with function body.

func _on_button_quit_main_menu_pressed():
	self.get_tree().quit(0)
	pass # Replace with function body.


func asdf():
	$"levels menu".set_deferred("visible",false)
	$"main menu".set_deferred("visible",true)
	pass # Replace with function body.

func _on_button_back_to_main_menu_pressed():
	$"main menu".set_deferred("visible",true)
	$"settings menu".set_deferred("visible",false)
	Globals.save_all()
	pass # Replace with function body.


func _on_button_thanksto_pressed():
	$"main menu".set_deferred("visible",false)
	$"thanks to menu".set_deferred("visible",true)
	pass # Replace with function body.


func _on_button_back_to_main_menu_from_thanks_pressed():
	$"thanks to menu".set_deferred("visible",false)
	$"main menu".set_deferred("visible",true)
	pass # Replace with function body.
