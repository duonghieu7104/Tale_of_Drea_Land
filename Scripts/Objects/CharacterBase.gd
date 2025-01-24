extends Resource

# CharacterBase.gd
class_name CharacterBase

# Các thuộc tính chung cho mọi nhân vật
@export var name_character : String

@export var level: int = 1
@export var exp : int = 0
@export var exp_to_next_level: int = 0
@export var texture_path: String
@export var description: String

@export var stats : CharacterStats = CharacterStats.new()
@export var equipped : Array = []
@export var skills : Array = []

func _init() -> void:
	equipped.resize(9)
	skills.resize(3)

func gain_exp(amount : int) -> void:
	exp += amount
	while exp >= exp_to_next_level:
		exp -= exp_to_next_level
		level_up()

func level_up() -> void:
	level += 1
	exp_to_next_level = int(exp_to_next_level * 1.5)

func check_level_up() -> void:
	if exp >= exp_to_next_level:
		level_up()

# Debug function to show stat progression
func show_stat_progression(stat_name: String, start_level: int = 1, end_level: int = 10):
	stats.print_stats_progression(start_level, end_level, stat_name)


# Function to get current stats at a specific level
func get_current_stats(current_level: int) -> Dictionary:
	return stats.calculate_stats(current_level)
	
func get_skill() -> Array:
	return skills

func equip(item : Equipments) -> void:
	equipped[item.slot] = item

func unequip(item : Equipments) -> void:
	equipped[item.slot] = null

func get_equipped() -> Array:
	return equipped
