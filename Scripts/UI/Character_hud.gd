extends Control

func _ready() -> void:
	$Panel/Avatar.change_avatar("res://Assets/Images/Avatar/avatar0.jpg")

func _process(delta: float) -> void:
	pass

func load_character():
	$Panel/Avatar.change_avatar("")

func update_states():
	pass
	
	
