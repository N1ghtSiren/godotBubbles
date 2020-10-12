extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Globals.background = $Background
	
	$"play menu".hide()
	$"levels menu".hide()
	$"level".hide()
	$"pause menu".hide()
	$"settings menu".hide()
	#load_game()
	#save_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_play_main_menu_pressed():
	$"main menu".set_deferred("visible",false)
	$"play menu".set_deferred("visible",true)
	pass

func _on_button_settings_main_menu_pressed():
	$"main menu".set_deferred("visible",false)
	$"settings menu".set_deferred("visible",true)
	pass # Replace with function body.

func _on_button_quit_main_menu_pressed():
	self.get_tree().quit(0)
	pass # Replace with function body.

func _on_button_market_play_menu_pressed():
	pass # Replace with function body.

func _on_button_levels_play_menu_pressed():
	$"play menu".set_deferred("visible",false)
	$"levels menu".set_deferred("visible",true)
	pass # Replace with function body.

func _on_button_back_play_menu_pressed():
	$"main menu".set_deferred("visible",true)
	$"play menu".set_deferred("visible",false)
	pass

func _on_main_menu_draw():
	pass # Replace with function body.


func _on_button_back_levels_menu_pressed():
	$"levels menu".set_deferred("visible",false)
	$"play menu".set_deferred("visible",true)
	pass # Replace with function body.

#save-load part
func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var node_data = Globals.save()
	save_game.store_line(to_json(node_data))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	
	if not save_game.file_exists("user://savegame.save"):
		print("nothing to load")
		return
	
	save_game.open("user://savegame.save", File.READ)
	
	var node_data = parse_json(save_game.get_line())
	
	Globals.money_green = node_data["money_green"]
	Globals.money_white = node_data["money_white"]
	Globals.money_orange = node_data["money_orange"]
	Globals.money_blue = node_data["money_blue"]
	
	save_game.close()


func _on_button_back_to_main_menu_pressed():
	$"main menu".set_deferred("visible",true)
	$"settings menu".set_deferred("visible",false)
	pass # Replace with function body.
