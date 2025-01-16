extends Node2D

var saveload = SaveLoad.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_save_pressed() -> void:
	saveload.save_data()


func _on_load_pressed() -> void:
	saveload.load_data()


func _on_generate_equipmet_pressed() -> void:
	var equipment = Equipments.new()
	var equip_generate = EquipmentGenerator.new()
	equipment = equip_generate.generate_random_equipment("weapon", "Black", 20)
	Globals.player.add_oject_to_inventory(equipment)

func _on_equip_pressed() -> void:
	var equipment = Equipments.new()
	var equip_generate = EquipmentGenerator.new()
	equipment = equip_generate.generate_random_equipment("weapon", "Black", 20)
	Globals.player.add_oject_to_inventory(equipment)
	Globals.player.add_oject_to_inventory(equipment)
	Globals.player.equip_equipment(Globals.player.inventory.equipments[0])


func _on_add_stats_to_player_pressed() -> void:
	Globals.player.add_equipment_stats_to_player()
