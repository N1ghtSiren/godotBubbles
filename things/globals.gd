extends Node2D

var background

var music_volume = 50
var pop_enabled = true

#f
var l_1_c = false
var l_2_c = false
var l_3_c = false
var l_4_c = false
var l_5_c = false
var l_6_c = false
var l_7_c = false
var l_8_c = false
var l_9_c = false
var l_10_c = false
var l_11_c = false
var l_12_c = false
var l_13_c = false
var l_14_c = false
var l_15_c = false
var l_16_c = false
var l_17_c = false
var l_18_c = false
var l_19_c = false
var l_20_c = false
var l_21_c = false
var l_22_c = false
var l_23_c = false
var l_24_c = false
var l_25_c = false
var l_26_c = false
var l_27_c = false
var l_28_c = false
var l_29_c = false
var l_30_c = false
var l_31_c = false
var l_32_c = false
var l_33_c = false
var l_34_c = false
var l_35_c = false
var l_36_c = false
var l_37_c = false
var l_38_c = false
var l_39_c = false
var l_40_c = false
var l_41_c = false
var l_42_c = false
var l_43_c = false
var l_44_c = false
var l_45_c = false
var l_46_c = false
var l_47_c = false
var l_48_c = false
var l_49_c = false
var l_50_c = false
#endf

func _ready():
	Globals.load_all()

func save():
	var save_dict = {
		"music_volume" : music_volume,
		"pop_enabled" : pop_enabled,
		"l_1_c" : l_1_c,
		"l_2_c" : l_2_c,
		"l_3_c" : l_3_c,
		"l_4_c" : l_4_c,
		"l_5_c" : l_5_c,
		"l_6_c" : l_6_c,
		"l_7_c" : l_7_c,
		"l_8_c" : l_8_c,
		"l_9_c" : l_9_c,
		"l_10_c" : l_10_c,
		"l_11_c" : l_11_c,
		"l_12_c" : l_12_c,
		"l_13_c" : l_13_c,
		"l_14_c" : l_14_c,
		"l_15_c" : l_15_c,
		"l_16_c" : l_16_c,
		"l_17_c" : l_17_c,
		"l_18_c" : l_18_c,
		"l_19_c" : l_19_c,
		"l_20_c" : l_20_c,
		"l_21_c" : l_21_c,
		"l_22_c" : l_22_c,
		"l_23_c" : l_23_c,
		"l_24_c" : l_24_c,
		"l_25_c" : l_25_c,
		"l_26_c" : l_26_c,
		"l_27_c" : l_27_c,
		"l_28_c" : l_28_c,
		"l_29_c" : l_29_c,
		"l_30_c" : l_30_c,
		"l_31_c" : l_31_c,
		"l_32_c" : l_32_c,
		"l_33_c" : l_33_c,
		"l_34_c" : l_34_c,
		"l_35_c" : l_35_c,
		"l_36_c" : l_36_c,
		"l_37_c" : l_37_c,
		"l_38_c" : l_38_c,
		"l_39_c" : l_39_c,
		"l_40_c" : l_40_c,
		"l_41_c" : l_41_c,
		"l_42_c" : l_42_c,
		"l_43_c" : l_43_c,
		"l_44_c" : l_44_c,
		"l_45_c" : l_45_c,
		"l_46_c" : l_46_c,
		"l_47_c" : l_47_c,
		"l_48_c" : l_48_c,
		"l_49_c" : l_49_c,
		"l_50_c" : l_50_c
	}
	return save_dict


func hide_bg():
	background.set_deferred("visible",false)

func show_bg():
	background.set_deferred("visible",true)

#save-load part
func save_all():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var node_data = save()
	save_game.store_line(to_json(node_data))
	save_game.close()

func load_all():
	var save_game = File.new()
	
	if not save_game.file_exists("user://savegame.save"):
		print("nothing to load")
		return
	
	save_game.open("user://savegame.save", File.READ)
	
	var node_data = parse_json(save_game.get_line())
	
	music_volume = node_data["music_volume"]
	pop_enabled = node_data["pop_enabled"]
	l_1_c = node_data["l_1_c"]
	l_2_c = node_data["l_2_c"]
	l_3_c = node_data["l_3_c"]
	l_4_c = node_data["l_4_c"]
	l_5_c = node_data["l_5_c"]
	l_6_c = node_data["l_6_c"]
	l_7_c = node_data["l_7_c"]
	l_8_c = node_data["l_8_c"]
	l_9_c = node_data["l_9_c"]
	l_10_c = node_data["l_10_c"]
	l_11_c = node_data["l_11_c"]
	l_12_c = node_data["l_12_c"]
	l_13_c = node_data["l_13_c"]
	l_14_c = node_data["l_14_c"]
	l_15_c = node_data["l_15_c"]
	l_16_c = node_data["l_16_c"]
	l_17_c = node_data["l_17_c"]
	l_18_c = node_data["l_18_c"]
	l_19_c = node_data["l_19_c"]
	l_20_c = node_data["l_20_c"]
	l_21_c = node_data["l_21_c"]
	l_22_c = node_data["l_22_c"]
	l_23_c = node_data["l_23_c"]
	l_24_c = node_data["l_24_c"]
	l_25_c = node_data["l_25_c"]
	l_26_c = node_data["l_26_c"]
	l_27_c = node_data["l_27_c"]
	l_28_c = node_data["l_28_c"]
	l_29_c = node_data["l_29_c"]
	l_30_c = node_data["l_30_c"]
	l_31_c = node_data["l_31_c"]
	l_32_c = node_data["l_32_c"]
	l_33_c = node_data["l_33_c"]
	l_34_c = node_data["l_34_c"]
	l_35_c = node_data["l_35_c"]
	l_36_c = node_data["l_36_c"]
	l_37_c = node_data["l_37_c"]
	l_38_c = node_data["l_38_c"]
	l_39_c = node_data["l_39_c"]
	l_40_c = node_data["l_40_c"]
	l_41_c = node_data["l_41_c"]
	l_42_c = node_data["l_42_c"]
	l_43_c = node_data["l_43_c"]
	l_44_c = node_data["l_44_c"]
	l_45_c = node_data["l_45_c"]
	l_46_c = node_data["l_46_c"]
	l_47_c = node_data["l_47_c"]
	l_48_c = node_data["l_48_c"]
	l_49_c = node_data["l_49_c"]
	l_50_c = node_data["l_50_c"]
	
	save_game.close()

func lvl_set_completed(leveln):
	set("l_"+str(leveln)+"_c",true)
	save_all()

func get_level_state(leveln):
	return get("l_"+str(leveln)+"_c")
