extends Node

class_name SaveLoad

var save_file_path = "user://sav.tres"

func save_data() -> void:
	var player = Globals.player
	var error = ResourceSaver.save(player, save_file_path)
	if error == OK:
		print("Save successfully")
	else:
		print("Save failed. Error code:", error)

func load_data() -> void:
	var player = ResourceLoader.load(save_file_path)
	if player:
		Globals.player = player
		print("Load save successfully")
	else:
		print("Failed to load file save")
