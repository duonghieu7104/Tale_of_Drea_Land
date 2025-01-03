extends Resource

class_name Equipments

@export var name : String
@export var type : String # helmet (giáp mũ) - ring (nhẫn) - necklace (vòng cổ) - weapon (vũ khí) - weapon (vũ khí) - armor1 (giáp thân) - armor2 (giáp) - gloves (găng tay) - boots (giày)
@export var rank : String # Grey - Green - Blue - Orange - Red - Purple - Black
@export var star : int
@export var level_requirement : int
@export var description : String
@export var weight : int
@export var stats : Dictionary
@export var bonus_stats : Dictionary
@export var effects : Dictionary

@export var texture_path : String
@export var rank_texture_path : String

var effectable : Effectable = Effectable.new()

#const IncreaseHpEffect = preload("res://Scripts/Objects/Effects/IncreaseHpEffect.gd")

func apply_equipment_effects(target):
	effectable.effects = self.stats
	effectable.apply_item_effects(target)

const RANK_DATA = {
	"Grey": {"multiplier": 0.6, "max_stats": 2, "bonus_chance": 0.1},
	"Green": {"multiplier": 0.8, "max_stats": 2, "bonus_chance": 0.2},
	"Blue": {"multiplier": 1.0, "max_stats": 3, "bonus_chance": 0.3},
	"Orange": {"multiplier": 1.2, "max_stats": 3, "bonus_chance": 0.4},
	"Red": {"multiplier": 1.4, "max_stats": 4, "bonus_chance": 0.5},
	"Purple": {"multiplier": 1.6, "max_stats": 4, "bonus_chance": 0.6},
	"Black": {"multiplier": 2.0, "max_stats": 5, "bonus_chance": 0.7}
}

const BASE_STATS = {
	"hp": {"base": 100, "min_bonus": 50, "max_bonus": 150},
	"mana": {"base": 50, "min_bonus": 25, "max_bonus": 75},
	"atk_phys": {"base": 30, "min_bonus": 15, "max_bonus": 45},
	"atk_spec": {"base": 30, "min_bonus": 15, "max_bonus": 45},
	"spd": {"base": 20, "min_bonus": 10, "max_bonus": 30},
	"def_phys": {"base": 25, "min_bonus": 12, "max_bonus": 37},
	"def_spec": {"base": 25, "min_bonus": 12, "max_bonus": 37},
	"counter_rate": {"base": 5, "min_bonus": 2, "max_bonus": 8},
	"block_rate": {"base": 5, "min_bonus": 2, "max_bonus": 8},
	"crit_rate": {"base": 5, "min_bonus": 2, "max_bonus": 8},
	"dodge_rate": {"base": 5, "min_bonus": 2, "max_bonus": 8}
}

const TYPE_AFFINITIES = {
	"helmet": {
		"primary": ["hp", "def_spec"],
		"secondary": ["mana", "def_phys"],
		"bonus_mult": 1.2
	},
	"armor1": {
		"primary": ["def_phys", "hp"],
		"secondary": ["block_rate", "counter_rate"],
		"bonus_mult": 1.3
	},
	"armor2": {
		"primary": ["def_spec", "mana"],
		"secondary": ["dodge_rate", "hp"],
		"bonus_mult": 1.3
	},
	"weapon": {
		"primary": ["atk_phys", "atk_spec"],
		"secondary": ["crit_rate", "spd"],
		"bonus_mult": 1.4
	},
	"boots": {
		"primary": ["spd", "dodge_rate"],
		"secondary": ["def_phys", "def_spec"],
		"bonus_mult": 1.2
	},
	"ring": {
		"primary": ["crit_rate", "counter_rate"],
		"secondary": ["atk_phys", "atk_spec"],
		"bonus_mult": 1.1
	},
	"necklace": {
		"primary": ["mana", "atk_spec"],
		"secondary": ["hp", "def_spec"],
		"bonus_mult": 1.1
	},
	"gloves": {
		"primary": ["block_rate", "counter_rate"],
		"secondary": ["atk_phys", "crit_rate"],
		"bonus_mult": 1.1
	}
}

var quality: float = randf_range(0.8, 1.2)

func _add_bonus_effect():
	var possible_effects = {
		"elemental_bonus": randf_range(0.05, 0.15),
		"status_resist": randf_range(0.1, 0.3),
		"gold_find": randf_range(0.05, 0.2),
		"exp_bonus": randf_range(0.05, 0.15)
	}
	var effect_type = possible_effects.keys()[randi() % possible_effects.size()]
	self.effects["bonus_" + effect_type] = possible_effects[effect_type]

func generate() -> Dictionary:
	var level_mult = 1.0 + (floor(level_requirement / 10.0) * 0.1)
	self.stats = {}
	
	if TYPE_AFFINITIES.has(self.type):
		var type_data = TYPE_AFFINITIES[self.type]
		var rank_data = RANK_DATA[self.rank]
		
		# Add primary stat
		var primary_stat = type_data["primary"][randi() % type_data["primary"].size()]
		self.stats[primary_stat] = _calculate_stat_value(primary_stat, level_mult, true)
		
		# Add secondary stats
		var max_stats = rank_data["max_stats"] - 1
		var additional_stats = randi() % max_stats + 1
		
		var available_stats = type_data["secondary"].duplicate()
		for stat in self.stats.keys():
			available_stats.erase(stat)
			
		for i in range(additional_stats):
			if available_stats.size() == 0:
				break
			var idx = randi() % available_stats.size()
			var stat = available_stats[idx]
			self.stats[stat] = _calculate_stat_value(stat, level_mult, false)
			available_stats.erase(available_stats[idx])
	
		if randf() < rank_data["bonus_chance"]:
			_add_bonus_effect()
	
	return self.stats

func _calculate_stat_value(stat: String, level_mult: float, is_primary: bool) -> int:
	var stat_data = BASE_STATS[stat]
	var rank_data = RANK_DATA[self.rank]
	var type_data = TYPE_AFFINITIES[self.type]
	
	var base = stat_data["base"]
	var bonus = randf_range(stat_data["min_bonus"], stat_data["max_bonus"])
	var rank_mult = rank_data["multiplier"]
	var type_mult = type_data["bonus_mult"] if is_primary else 1.0
	
	return int((base + bonus) * rank_mult * level_mult * type_mult * quality)
