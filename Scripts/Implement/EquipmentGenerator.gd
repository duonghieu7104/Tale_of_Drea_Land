extends Node

class_name EquipmentGenerator

const ALL_STATS = ["hp", "mana", "atk_phys", "atk_spec", "spd", "def_phys", "def_spec"]
const SPECIAL_STATS = ["counter_rate", "block_rate", "crit_rate", "dodge_rate"]
const WEAPON_TYPES = ["physical", "magical", "defensive", "hybrid"]

# Base stats values for level 10 (Blue rank)
const BASE_VALUES = {
	"hp": 15,
	"mana": 10,
	"atk_phys": 8,
	"atk_spec": 8,
	"spd": 5,
	"def_phys": 6,
	"def_spec": 6,
}

# Rank multipliers adjusted for better scaling
const RANK_MULTIPLIERS = {
	"Grey": 0.6,
	"Green": 0.8,
	"Blue": 1.0,
	"Orange": 1.15,
	"Red": 1.3,
	"Purple": 1.5,
	"Black": 1.8
}


func generate_random_equipment(type: String, rank: String, level_req: int) -> Equipments:
	var equipment = Equipments.new()
	equipment.type = type
	equipment.rank = rank
	equipment.level_requirement = level_req
	equipment.star = 0
	
	# Level scaling (every 10 levels adds 25% to base)
	var level_multiplier = 1.0 + ((level_req - 10) / 10.0) * 0.25
	var rank_multiplier = RANK_MULTIPLIERS[rank]
	
	equipment.weight = {
		"armor1": randi_range(80, 100),
		"armor2": randi_range(80, 100),
		"weapon": randi_range(60, 80),
		"helmet": randi_range(40, 60),
		"boots": randi_range(30, 40),
		"gloves": randi_range(20, 30),
		"ring": randi_range(10, 20),
		"necklace": randi_range(10, 20)
	}[type]
	
	equipment.base_stats = {}
	equipment.bonus_stats_1 = {}
	equipment.bonus_stats_2 = {}
	
	match type:
		"helmet":
			add_stat(equipment.base_stats, "hp", BASE_VALUES["hp"], level_multiplier, rank_multiplier)
		"ring":
			add_stat(equipment.base_stats, "mana", BASE_VALUES["mana"], level_multiplier, rank_multiplier)
		"necklace":
			if randf() > 0.5:
				add_stat(equipment.base_stats, "atk_phys", BASE_VALUES["atk_phys"], level_multiplier, rank_multiplier)
			else:
				add_stat(equipment.base_stats, "atk_spec", BASE_VALUES["atk_spec"], level_multiplier, rank_multiplier)
		"weapon":
			var weapon_type = WEAPON_TYPES[randi() % WEAPON_TYPES.size()]
			match weapon_type:
				"physical":
					add_stat(equipment.base_stats, "atk_phys", BASE_VALUES["atk_phys"] * 1.2, level_multiplier, rank_multiplier)
				"magical":
					add_stat(equipment.base_stats, "atk_spec", BASE_VALUES["atk_spec"] * 1.2, level_multiplier, rank_multiplier)
				"defensive":
					add_stat(equipment.base_stats, "def_phys", BASE_VALUES["def_phys"], level_multiplier, rank_multiplier)
					add_stat(equipment.base_stats, "def_spec", BASE_VALUES["def_spec"], level_multiplier, rank_multiplier)
				"hybrid":
					add_stat(equipment.base_stats, "atk_spec", BASE_VALUES["atk_spec"], level_multiplier, rank_multiplier)
		"gloves":
			var random_stat = ALL_STATS[randi() % ALL_STATS.size()]
			add_stat(equipment.base_stats, random_stat, BASE_VALUES[random_stat] * 0.8, level_multiplier, rank_multiplier)
		"boots":
			add_stat(equipment.base_stats, "spd", BASE_VALUES["spd"], level_multiplier, rank_multiplier)
	
	# Bonus stats với giá trị thấp hơn base
	if rank in ["Orange", "Red", "Purple", "Black"]:
		add_bonus_stats_1(equipment, type, level_multiplier, rank_multiplier)
	
	if rank in ["Purple", "Black"]:
		add_bonus_stats_2(equipment, level_multiplier, rank_multiplier)
	
	equipment.name = generate_equipment_name(type, rank)
	equipment.description = generate_equipment_description(equipment)
	
	return equipment

func add_stat(stats_dict: Dictionary, stat_name: String, base_value: float, level_mult: float, rank_mult: float):
	stats_dict[stat_name] = int(base_value * level_mult * rank_mult)

func add_bonus_stats_1(equipment: Equipments, type: String, level_mult: float, rank_mult: float):
	var num_bonus = 1 if rank_mult < 1.5 else 2
	var bonus_multiplier = 0.4  # Bonus stats are 40% của base stats
	
	match type:
		"helmet":
			add_stat(equipment.bonus_stats_1, "def_phys", BASE_VALUES["def_phys"] * bonus_multiplier, level_mult, rank_mult)
			if num_bonus > 1:
				add_stat(equipment.bonus_stats_1, "def_spec", BASE_VALUES["def_spec"] * bonus_multiplier, level_mult, rank_mult)
		"ring", "necklace", "boots", "gloves":
			var available_stats = ALL_STATS.duplicate()
			for _i in range(num_bonus):
				if available_stats.is_empty(): break
				var stat = available_stats.pop_at(randi() % available_stats.size())
				add_stat(equipment.bonus_stats_1, stat, BASE_VALUES[stat] * bonus_multiplier, level_mult, rank_mult)
		"weapon":
			if "atk_spec" in equipment.base_stats:
				if randf() > 0.5:
					add_stat(equipment.bonus_stats_1, "spd", BASE_VALUES["spd"] * bonus_multiplier, level_mult, rank_mult)
				else:
					add_stat(equipment.bonus_stats_1, "mana", BASE_VALUES["mana"] * bonus_multiplier, level_mult, rank_mult)

func add_bonus_stats_2(equipment: Equipments, level_mult: float, rank_mult: float):
	var num_bonus = 1 if rank_mult < 1.8 else 2
	var available_stats = SPECIAL_STATS.duplicate()
	
	for _i in range(num_bonus):
		if available_stats.is_empty(): break
		var stat = available_stats.pop_at(randi() % available_stats.size())
		# Special stats có base là 2-3%
		add_stat(equipment.bonus_stats_2, stat, 2, level_mult, rank_mult)

func generate_equipment_name(type: String, rank: String) -> String:
	return rank + " " + type.capitalize()

func generate_equipment_description(equipment: Equipments) -> String:
	return "Level " + str(equipment.level_requirement) + " " + equipment.name
