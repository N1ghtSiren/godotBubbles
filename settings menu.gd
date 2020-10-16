extends Node2D


onready var music_volume_text = $text_music_volume
onready var pop_flag_text = $text_pop_flag

# Called when the node enters the scene tree for the first time.
func _ready():
	music_volume_text.set_text(str(Globals.music_volume)+"%")
	if(Globals.pop_enabled==true):
		pop_flag_text.set_text(str("yes"))
	elif(Globals.pop_enabled==false):
		pop_flag_text.set_text(str("no"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_music_decrease_pressed():
	if(Globals.music_volume>0):
		Globals.music_volume = Globals.music_volume - 5
		$"../BGM".set_volume(Globals.music_volume/1)
		music_volume_text.set_text(str(Globals.music_volume)+"%")


func _on_button_music_increase_pressed():
	if(Globals.music_volume<200):
		Globals.music_volume = Globals.music_volume + 5
		$"../BGM".set_volume(Globals.music_volume/1)
		music_volume_text.set_text(str(Globals.music_volume)+"%")


func _on_button_pop_left_pressed():
	if(Globals.pop_enabled==false):
		Globals.pop_enabled = true
		pop_flag_text.set_text(str("yes"))
	elif(Globals.pop_enabled==true):
		Globals.pop_enabled = false
		pop_flag_text.set_text(str("no"))
	pass # Replace with function body.


func _on_button_pop_right_pressed():
	if(Globals.pop_enabled==false):
		Globals.pop_enabled = true
		pop_flag_text.set_text(str("yes"))
	elif(Globals.pop_enabled==true):
		Globals.pop_enabled = false
		pop_flag_text.set_text(str("no"))
	pass # Replace with function body.
