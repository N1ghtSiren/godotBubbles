extends Node2D

onready var pop1 = $pop1
onready var pop2 = $pop2
onready var pop3 = $pop3
onready var pop4 = $pop4
onready var pop5 = $pop5

func play():
	if(pop1.is_playing()==false):
		pop1.play()
		return true
	if(pop2.is_playing()==false):
		pop2.play()
		return true
	if(pop3.is_playing()==false):
		pop3.play()
		return true
	if(pop4.is_playing()==false):
		pop4.play()
		return true
	if(pop5.is_playing()==false):
		pop5.play()
		return true
	
	return false
