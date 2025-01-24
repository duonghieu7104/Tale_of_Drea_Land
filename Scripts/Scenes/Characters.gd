extends Control


func _ready() -> void:
	var equipped_ui = get_node("Panel/VBoxContainer/Panel/VBoxContainer/Panel/EquippedUI")
	if equipped_ui != null:
		equipped_ui.connect("idx_slot", Callable(self, "on_show_equipped"))
	else:
		print("Node 'EquippedUI' not found. Please check the node path.")


func _on_pre_pressed() -> void:
	pass # Replace with function body.


func _on_next_pressed() -> void:
	pass # Replace with function body.

func on_show_equipped(idx : int) -> void:
	print(idx)
