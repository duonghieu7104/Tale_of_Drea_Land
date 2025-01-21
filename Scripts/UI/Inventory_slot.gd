extends TextureButton

func _ready() -> void:
	pass

func load_ui_object(obj):
	if obj is Equipments:
		var path_frame_rank = "res://Assets/Images/Frame_rank/frame-" + obj.rank.to_lower() + ".png"
		$TextureRect.texture = load(path_frame_rank)
		$".".texture_normal = load(obj.texture_path)
	elif obj is Items:
		pass
	elif obj is Story_items:
		pass
	elif obj is Others:
		pass
	else:
		print("Unkown this Obj")

func click_in_slot():
	pass
