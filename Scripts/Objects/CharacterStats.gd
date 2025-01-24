extends Resource

class_name CharacterStats

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

# Custom growth patterns for each stat in different level ranges
var growth_patterns = {}

# Calculate growth for a specific stat
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

# Get the appropriate growth pattern for the current level
func get_level_pattern(level: int, stat_name: String) -> Dictionary:
	var patterns = growth_patterns[stat_name]
	for level_range in patterns.keys():
		var range_parts = level_range.split("-")
		var min_level = int(range_parts[0])
		var max_level = int(range_parts[1])
		
		if level >= min_level and level <= max_level:
			return patterns[level_range]
	
	return {"type": "linear", "rate": 1.0}  # Default pattern

# Calculate all stats for the current level
func calculate_stats(level: int) -> Dictionary:
	var current_stats = {}
	
	for stat_name in base_stats.keys():
		current_stats[stat_name] = calculate_growth(level, base_stats[stat_name], stat_name)
	
	return current_stats

# Debug function to print stats progression
func print_stats_progression(start_level: int, end_level: int, stat_name: String):
	print("Stats progression for %s from level %d to %d:" % [stat_name, start_level, end_level])
	for level in range(start_level, end_level + 1):
		var stats = calculate_stats(level)
		print("Level %d: %.1f" % [level, stats[stat_name]])
