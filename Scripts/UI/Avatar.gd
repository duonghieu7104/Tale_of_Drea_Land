extends Control


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func change_avatar(path : String):
	$Image.texture = load(path)
