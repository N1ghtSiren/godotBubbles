extends AudioStreamPlayer

func _ready():
	set_volume(Globals.music_volume)

func set_volume(db):
	if(db==0):
		stop()
	else:
		if(is_playing()==false):
			play()
		db = db/10 - 5
		set_volume_db(db)
