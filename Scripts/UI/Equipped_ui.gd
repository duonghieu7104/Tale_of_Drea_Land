extends Control

@onready var slot_0 = $Panel/HBoxContainer/VBoxContainer/slot_0
@onready var slot_1 = $Panel/HBoxContainer/VBoxContainer2/slot_1
@onready var slot_2 = $Panel/HBoxContainer/VBoxContainer/slot_2
@onready var slot_3 = $Panel/HBoxContainer/slot_3
@onready var slot_4 = $Panel/HBoxContainer/VBoxContainer3/slot_4
@onready var slot_5 = $Panel/HBoxContainer/VBoxContainer2/slot_5
@onready var slot_6 = $Panel/HBoxContainer/VBoxContainer3/slot_6
@onready var slot_7 = $Panel/HBoxContainer/VBoxContainer4/slot_7
@onready var slot_8 = $Panel/HBoxContainer/VBoxContainer4/slot_8

func _ready() -> void:
	pass

func load_ui(equipped : Array):
	for i in equipped.size():
		var path : String = equipped[i].texture_path
		get_node("Panel/HBoxContainer/VBoxContainer/slot_" + str(i)).texture_normal = load(path)
