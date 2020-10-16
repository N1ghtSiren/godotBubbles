extends Node2D

onready var pop1 = $pop1

func play():
	if(Globals.pop_enabled==true):
		pop1.play()
