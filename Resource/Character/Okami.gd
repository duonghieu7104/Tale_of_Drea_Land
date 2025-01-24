extends Resource

class_name Okami

@export var char_base : CharacterBase = CharacterBase.new()

func _init():

	char_base.name_character = "Okami"
	char_base.texture_path = "res://Assets/Images/Avatar/Okami.png"
	# Customize base stats for Okami
	char_base.stats.base_stats = {
		"hp": 60,     # Higher base HP
		"mana": 55,   # More mana
		"atk_phys": 35,
		"atk_spec": 50,
		"def_phys": 30,
		"def_spec": 40,
		"spd": 45
	}

	# Customize growth patterns for each stat
	char_base.stats.growth_patterns = {
		"hp": {
				"1-30": {"type": "linear", "rate": 1.2},
				"31-60": {"type": "linear", "rate": 1.0},
				"61-100": {"type": "fast", "rate": 1.3}
			},
		"mana": {
				"1-30": {"type": "fast", "rate": 1.5},
				"31-60": {"type": "linear", "rate": 1.0},
				"61-100": {"type": "linear", "rate": 1.1}
			},
		"atk_phys": {
				"1-30": {"type": "slow", "rate": 0.8},
				"31-60": {"type": "linear", "rate": 1.0},
				"61-100": {"type": "fast", "rate": 1.2}
			},
		"atk_spec": {
				"1-30": {"type": "fast", "rate": 1.3},
				"31-60": {"type": "linear", "rate": 1.0},
				"61-100": {"type": "fast", "rate": 1.2}
			},
		"def_phys": {
				"1-30": {"type": "slow", "rate": 0.7},
				"31-60": {"type": "linear", "rate": 1.0},
				"61-100": {"type": "linear", "rate": 1.1}
			},
		"def_spec": {
				"1-30": {"type": "linear", "rate": 1.0},
				"31-60": {"type": "slow", "rate": 0.8},
				"61-100": {"type": "fast", "rate": 1.3}
			},
		"spd": {
				"1-30": {"type": "fast", "rate": 1.2},
				"31-60": {"type": "linear", "rate": 1.0},
				"61-100": {"type": "linear", "rate": 1.1}
			}
	}

	char_base.skills = [Skill1.new(), Skill2.new(), Skill3.new()]
