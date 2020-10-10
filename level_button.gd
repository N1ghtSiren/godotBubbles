extends Node2D

signal tap

var n
var text

# Called when the node enters the scene tree for the first time.

func prepare(var_text,var_n,var_parent):
	text = var_text
	n = var_n
	connect("tap",var_parent,"on_tap",[n])

func _ready():
	$Label.set_text(text)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TouchScreenButton_pressed():
	emit_signal("tap")
	pass # Replace with function body.
