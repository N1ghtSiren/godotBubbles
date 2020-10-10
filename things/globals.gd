extends Node2D

var money_green
var money_white
var money_blue
var money_orange

func save():
	var save_dict = {
		"money_green" : money_green,
		"money_white" : money_white,
		"money_orange" : money_orange,
		"money_blue" : money_blue
	}
	return save_dict
