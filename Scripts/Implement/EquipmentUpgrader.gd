extends Node

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
		return 1.0 + (increase * 0.1)  # Tăng 10% mỗi star dưới 10
	elif current_star < 20:
		return 1.0 + (increase * 0.05)  # Tăng 5% mỗi star 10-20
	else:
		return 1.0 + (increase * 0.02)  # Tăng 2% mỗi star trên 20

func modify_stats(stats: Dictionary, multiplier: float):
	for stat in stats:
		var new_value = int(stats[stat] * multiplier)
		stats[stat] = max(1, new_value)  # Không cho phép stats = 0

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
	return {"success": false, "star_change": -2}

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
	return {"success": false, "star_change": -1}

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
