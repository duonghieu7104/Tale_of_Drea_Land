extends CharacterBase 

class_name Alice
 # Giả sử bạn có một class cơ sở

# Base stats
var base_stats = {
	"hp": 50,
	"mana": 40,
	"atk_phys": 30,
	"atk_spec": 45,
	"def_phys": 25,
	"def_spec": 35,
	"spd": 40
}

# Custom growth patterns cho từng stat ở các level range khác nhau
var growth_patterns = {
	"hp": {
		"1-30": {"type": "slow", "rate": 0.7},
		"31-60": {"type": "linear", "rate": 1.0},
		"61-100": {"type": "fast", "rate": 1.5}
	},
	"mana": {
		"1-30": {"type": "fast", "rate": 1.4},
		"31-60": {"type": "slow", "rate": 0.8},
		"61-100": {"type": "linear", "rate": 1.0}
	},
	# Thêm các stats khác tương tự
}

# Các hàm tính toán growth
func calculate_growth(level: int, base_value: float, stat_name: String) -> float:
	var current_pattern = get_level_pattern(level, stat_name)
	var growth_type = current_pattern["type"]
	var growth_rate = current_pattern["rate"]
	
	match growth_type:
		"slow":
			return base_value * (1 + (growth_rate * sqrt(level) / 10))
		"linear":
			return base_value * (1 + (growth_rate * level / 10))
		"fast":
			return base_value * (1 + (growth_rate * pow(level, 1.2) / 10))
	
	return base_value

# Lấy pattern phù hợp với level hiện tại
func get_level_pattern(level: int, stat_name: String) -> Dictionary:
	var patterns = growth_patterns[stat_name]
	for level_range in patterns.keys():
		var range_parts = level_range.split("-")
		var min_level = int(range_parts[0])
		var max_level = int(range_parts[1])
		
		if level >= min_level and level <= max_level:
			return patterns[level_range]
	
	return {"type": "linear", "rate": 1.0}  # Default pattern

# Tính toán tất cả stats ở level hiện tại
func calculate_stats(level: int) -> Dictionary:
	var current_stats = {}
	
	for stat_name in base_stats.keys():
		current_stats[stat_name] = calculate_growth(level, base_stats[stat_name], stat_name)
	
	return current_stats

# Hàm debug để kiểm tra growth
func print_stats_progression(start_level: int, end_level: int, stat_name: String):
	print("Stats progression for %s from level %d to %d:" % [stat_name, start_level, end_level])
	for level in range(start_level, end_level + 1):
		var stats = calculate_stats(level)
		print("Level %d: %.1f" % [level, stats[stat_name]])
