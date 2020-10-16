extends Node2D

signal tap

var n
var text

# Called when the node enters the scene tree for the first time.
func update():
	if(Globals.get_level_state(int(text))==true):
		$Label.set("custom_colors/font_color", Color(0.2,0.75,0.2))
		$Label.set("custom_colors/font_outline_modulate", Color(0.2,0.75,0.2))
		$Label.set("custom_colors/font_color_shadow", Color(0.2,0.3,0.2))

func prepare(var_text,var_n,var_parent):
	text = var_text
	n = var_n
	connect("tap",var_parent,"on_tap",[n])
	update()

func _ready():
	$Label.set_text(text)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TouchScreenButton_pressed():
	emit_signal("tap")
	pass # Replace with function body.
