extends Control


func _ready() -> void:
	$PanelContainer/Equipment.get_v_scroll_bar().modulate = Color(0, 0, 0, 0)
	#$PanelContainer/Item.get_v_scroll_bar().modulate = Color(0, 0, 0, 0)

func _process(delta: float) -> void:
	pass
