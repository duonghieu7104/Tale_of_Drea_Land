extends Resource

class_name Equipments

@export var name: String
@export var type: String # helmet (giáp mũ) - ring (nhẫn) - necklace (vòng cổ) - weapon (vũ khí) - weapon (vũ khí) - armor1 (giáp thân) - armor2 (giáp) - gloves (găng tay) - boots (giày)
@export var rank: String # Grey - Green - Blue - Orange - Red - Purple - Black
@export var star: int
@export var level_requirement: int
@export var description: String
@export var weight: int
@export var base_stats: Dictionary
@export var bonus_stats_1: Dictionary
@export var bonus_stats_2: Dictionary
@export var effects: Dictionary

@export var texture_path: String
@export var rank_texture_path: String

var effectable: Effectable = Effectable.new()

#const IncreaseHpEffect = preload("res://Scripts/Objects/Effects/IncreaseHpEffect.gd")

func _init() -> void:
	pass

func apply_equipment_effects(target):
	effectable.effects = self.stats
	effectable.apply_item_effects(target)

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
	var bonus_multiplier = 0.4 # Bonus stats are 40% của base stats
	
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

const WEIGHT_LIMIT = {
	"armor1": 150,
	"armor2": 150,
	"weapon": 120,
	"helmet": 90,
	"boots": 70,
	"gloves": 50,
	"ring": 40,
	"necklace": 40
}

const GEM_POWER = {
   "Grey": 1,
   "Green": 3,
   "Blue": 9,
   "Orange": 27,
   "Red": 81,
   "Purple": 243,
   "Black": 729
}

func upgrade_equipment(equipment: Equipments, gems: Dictionary) -> Dictionary:
	# gems format: {"Grey": 5, "Green": 2, etc}
	var total_power = 0
	for gem_type in gems:
		total_power += GEM_POWER[gem_type] * gems[gem_type]
   
	var required_power = get_required_gems(equipment) * GEM_POWER["Grey"]
	if total_power < required_power:
		return {"success": false, "star_change": 0, "message": "Không đủ đá nâng cấp"}
		
	var upgrade_chance = 0.0
	var weighted_chance = 0.0
	for gem_type in gems:
		var gem_contribution = (GEM_POWER[gem_type] * gems[gem_type]) / float(total_power)
		weighted_chance += calculate_upgrade_chance(equipment, gem_type) * gem_contribution
   
	var random = randf()
	var result = {"success": false, "star_change": 0}
   
	if random > weighted_chance:
	# Thất bại
		if random < weighted_chance + 0.2:
			result = downgrade_star_2(equipment)
		else:
			result = downgrade_star_1(equipment)
	else:
		# Thành công
		var power_ratio = total_power / float(required_power)
		if power_ratio >= 3.0:
			result = upgrade_star_5(equipment)
		elif power_ratio >= 2.0:
			result = upgrade_star_3(equipment)
		else:
			result = upgrade_star_2(equipment)
		   
	return result

func get_stat_multiplier(current_star: int, increase: int) -> float:
	if current_star < 10:
		return 1.0 + (increase * 0.1) # Tăng 10% mỗi star dưới 10
	elif current_star < 20:
		return 1.0 + (increase * 0.05) # Tăng 5% mỗi star 10-20
	else:
		return 1.0 + (increase * 0.02) # Tăng 2% mỗi star trên 20

func modify_stats(stats: Dictionary, multiplier: float):
	for stat in stats:
		var new_value = int(stats[stat] * multiplier)
		stats[stat] = max(1, new_value) # Không cho phép stats = 0

func downgrade_star_2(equipment: Equipments) -> Dictionary:
	if equipment.star <= 0:
		return {"success": false, "star_change": 0}
	
	var multiplier = get_stat_multiplier(equipment.star, -2)
	modify_stats(equipment.base_stats, multiplier)
	if not equipment.bonus_stats_1.is_empty():
		modify_stats(equipment.bonus_stats_1, multiplier)
	if not equipment.bonus_stats_2.is_empty():
		modify_stats(equipment.bonus_stats_2, multiplier)
	
	equipment.star = max(0, equipment.star - 2)
	return {"success": false, "star_change": - 2}

func downgrade_star_1(equipment: Equipments) -> Dictionary:
	if equipment.star <= 0:
		return {"success": false, "star_change": 0}
	
	var multiplier = get_stat_multiplier(equipment.star, -1)
	modify_stats(equipment.base_stats, multiplier)
	if not equipment.bonus_stats_1.is_empty():
		modify_stats(equipment.bonus_stats_1, multiplier)
	if not equipment.bonus_stats_2.is_empty():
		modify_stats(equipment.bonus_stats_2, multiplier)
	
	equipment.star = max(0, equipment.star - 1)
	return {"success": false, "star_change": - 1}

func upgrade_star_2(equipment: Equipments) -> Dictionary:
	var multiplier = get_stat_multiplier(equipment.star, 2)
	modify_stats(equipment.base_stats, multiplier)
	if not equipment.bonus_stats_1.is_empty():
		modify_stats(equipment.bonus_stats_1, multiplier)
	if not equipment.bonus_stats_2.is_empty():
		modify_stats(equipment.bonus_stats_2, multiplier)
	
	if equipment.weight < WEIGHT_LIMIT[equipment.type]:
		var weight_multiplier = 1.05 if equipment.star < 10 else 1.0
		equipment.weight = min(WEIGHT_LIMIT[equipment.type],
			int(equipment.weight * weight_multiplier))
	
	equipment.star += 2
	return {"success": true, "star_change": 2}

func upgrade_star_3(equipment: Equipments) -> Dictionary:
	var multiplier = get_stat_multiplier(equipment.star, 3)
	modify_stats(equipment.base_stats, multiplier)
	if not equipment.bonus_stats_1.is_empty():
		modify_stats(equipment.bonus_stats_1, multiplier)
	if not equipment.bonus_stats_2.is_empty():
		modify_stats(equipment.bonus_stats_2, multiplier)
	
	if equipment.weight < WEIGHT_LIMIT[equipment.type]:
		var weight_multiplier = 1.08 if equipment.star < 10 else 1.0
		equipment.weight = min(WEIGHT_LIMIT[equipment.type],
			int(equipment.weight * weight_multiplier))
	
	equipment.star += 3
	return {"success": true, "star_change": 3}

func upgrade_star_5(equipment: Equipments) -> Dictionary:
	var multiplier = get_stat_multiplier(equipment.star, 5)
	modify_stats(equipment.base_stats, multiplier)
	if not equipment.bonus_stats_1.is_empty():
		modify_stats(equipment.bonus_stats_1, multiplier)
	if not equipment.bonus_stats_2.is_empty():
		modify_stats(equipment.bonus_stats_2, multiplier)
	
	equipment.star += 5
	return {"success": true, "star_change": 5}

enum GemRank {GREY, GREEN, BLUE, ORANGE, RED, PURPLE, BLACK}

func combine_gems(gem_rank: String, amount: int) -> Dictionary:
	var result = {"success": false, "new_gem": null}
	
	# Kiểm tra số lượng đá tối thiểu
	var required_amount = 3
	if amount < required_amount:
		return result
		
	# Xác suất thành công theo rank
	var success_rates = {
		"Grey": 1,
		"Green": 0.9,
		"Blue": 0.8,
		"Orange": 0.7,
		"Red": 0.6,
		"Purple": 0.5,
		"Black": 0.4
	}
	
	# Thêm 5% tỉ lệ thành công cho mỗi đá vượt quá required_amount
	var bonus_rate = (amount - required_amount) * 0.05
	var final_rate = min(success_rates[gem_rank] + bonus_rate, 1.0)
	
	if randf() <= final_rate:
		var ranks = ["Grey", "Green", "Blue", "Orange", "Red", "Purple", "Black"]
		var current_index = ranks.find(gem_rank)
		if current_index < ranks.size() - 1:
			result.success = true
			result.new_gem = ranks[current_index + 1]
			
	return result

func calculate_upgrade_chance(equipment: Equipments, gem_rank: String) -> float:
	var base_chances = {
		"Grey": 0.9,
		"Green": 0.8,
		"Blue": 0.7,
		"Orange": 0.6,
		"Red": 0.5,
		"Purple": 0.4,
		"Black": 0.3
	}
	
	# Giảm tỉ lệ theo star
	var star_penalty = 0.0
	if equipment.star < 10:
		star_penalty = equipment.star * 0.02
	elif equipment.star < 20:
		star_penalty = 0.2 + (equipment.star - 10) * 0.03
	else:
		star_penalty = 0.5 + (equipment.star - 20) * 0.04
		
	return max(base_chances[gem_rank] - star_penalty, 0.05) # Tối thiểu 5% thành công

func get_required_gems(equipment: Equipments) -> int:
	var base_amount = 1
	
	if equipment.star < 10:
		return base_amount + equipment.star
	elif equipment.star < 20:
		return base_amount + 10 + (equipment.star - 10) * 2
	else:
		return base_amount + 30 + (equipment.star - 20) * 3
