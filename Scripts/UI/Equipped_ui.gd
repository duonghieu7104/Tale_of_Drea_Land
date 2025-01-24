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

signal idx_slot(idx)

func _ready() -> void:
	var buttons = get_tree().get_nodes_in_group("btn_slot")
	for button in buttons:
		button.connect("pressed", Callable(self, "on_btn_slot").bind(button))

func on_btn_slot(button):
	match button.name:
		"slot_0":
			emit_signal("idx_slot", 0)
		"slot_1":
			emit_signal("idx_slot", 1)
		"slot_2":
			emit_signal("idx_slot", 2)
		"slot_3":
			emit_signal("idx_slot", 3)
		"slot_4":
			emit_signal("idx_slot", 4)
		"slot_5":
			emit_signal("idx_slot", 5)
		"slot_6":
			emit_signal("idx_slot", 6)
		"slot_7":
			emit_signal("idx_slot", 7)
		"slot_8":
			emit_signal("idx_slot", 8)
