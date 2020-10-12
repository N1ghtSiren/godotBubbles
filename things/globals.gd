extends Node2D

var money_green
var money_white
var money_blue
var money_orange

var background

var music_volume = 50
var pop_enabled = true

func save():
	var save_dict = {
		"music_volume" : music_volume,
		"pop_enabled" : pop_enabled
	}
	return save_dict


func hide_bg():
	background.set_deferred("visible",false)
	
func show_bg():
	background.set_deferred("visible",true)
