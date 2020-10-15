extends AudioStreamPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_volume(db):
	if(db==0):
		stop()
		print(db)
	else:
		if(is_playing()==false):
			play()
		db = db/10 - 5
		set_volume_db(db)
