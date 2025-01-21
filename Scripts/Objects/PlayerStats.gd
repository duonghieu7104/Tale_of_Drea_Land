extends Resource

class_name PlayerStats

@export var level: int = 60
@export var exp: int = 0
@export var exp_to_next_level: int = 100

# _int
@export var base_hp: int
@export var base_mana: int
@export var base_atk_phys: int
@export var base_atk_spec: int
@export var base_spd: int
@export var base_def_phys: int
@export var base_def_spec: int

# _int -> calculate_stats (_int) -> 
@export var hp: int
@export var mana: int
@export var atk_phys: int
@export var atk_spec: int
@export var spd: int
@export var def_phys: int
@export var def_spec: int

# add stats from equipment
@export var total_hp: int
@export var total_mana: int
@export var total_atk_phys: int
@export var total_atk_spec: int
@export var total_spd: int
@export var total_def_phys: int
@export var total_def_spec: int

@export var vitality: int # Tăng tiến HP
@export var wisdom: int # Tăng tiến Mana
@export var strength: int # Tăng tiến ATK vật lý
@export var intelligence: int # Tăng tiến ATK phép thuật
@export var agility: int # Tăng tiến Tốc độ
@export var endurance: int # Tăng tiến DEF vật lý
@export var resistance: int # Tăng tiến DEF phép thuật

@export var nature: String

@export var class_player: String
# 1. Guardian: Vật lí Def cao, phòng thủ phản đòn, chậm chạp.
# 2. Assassin: Nhanh nhẹn nhất, sát thương vật lí dựa vào tốc độ để ra đòn nhanh.
# 3. Mage: Máu ít, sát thương phép.
# 4. Berserker: Chậm vừa, sát thương vật lí cực cao.
# 5. Paladin: Kết hợp giữa phòng thủ và hồi máu, có khả năng bảo vệ đồng đội.
# 6. Ranger: Sử dụng cung tên hoặc vũ khí tầm xa, nhanh nhẹn và linh hoạt.
# 7. Warlock: Sử dụng phép thuật hắc ám, có khả năng triệu hồi và gây sát thương theo thời gian.
# 8. Druid: Sử dụng phép thuật tự nhiên, có khả năng biến hình và hồi máu.
# 9. Monk: Sử dụng võ thuật, nhanh nhẹn và có khả năng né tránh cao.

enum CharacterClass {
	GUARDIAN,
	ASSASSIN,
	MAGE,
	BERSERKER,
	PALADIN,
	RANGER,
	WARLOCK,
	DRUID,
	MONK
}

func apply_nature_effects():
	match nature:
		"Lonely":
			base_atk_phys += 10
			base_def_phys -= 10
		"Brave":
			base_atk_phys += 10
			base_spd -= 10
		"Adamant":
			base_atk_phys += 10
			base_atk_spec -= 10
		"Naughty":
			base_atk_phys += 10
			base_def_spec -= 10
		"Bold":
			base_def_phys += 10
			base_atk_phys -= 10
		"Relaxed":
			base_def_phys += 10
			base_spd -= 10
		"Impish":
			base_def_phys += 10
			base_atk_spec -= 10
		"Lax":
			base_def_phys += 10
			base_def_spec -= 10
		"Timid":
			base_spd += 10
			base_atk_phys -= 10
		"Hasty":
			base_spd += 10
			base_def_phys -= 10
		"Jolly":
			base_spd += 10
			base_atk_spec -= 10
		"Naive":
			base_spd += 10
			base_def_spec -= 10
		"Modest":
			base_atk_spec += 10
			base_atk_phys -= 10
		"Mild":
			base_atk_spec += 10
			base_def_phys -= 10
		"Quiet":
			base_atk_spec += 10
			base_spd -= 10
		"Rash":
			base_atk_spec += 10
			base_def_spec -= 10
		"Calm":
			base_def_spec += 10
			base_atk_phys -= 10
		"Gentle":
			base_def_spec += 10
			base_def_phys -= 10
		"Sassy":
			base_def_spec += 10
			base_spd -= 10
		"Careful":
			base_def_spec += 10
			base_atk_spec -= 10
		_:
			print("Unknown nature:", nature)

# Base stats multipliers cho từng class
var CLASS_MULTIPLIERS = {
	CharacterClass.GUARDIAN: {
		"hp": 1.4,
		"mana": 0.6,
		"atk_phys": 0.8,
		"atk_spec": 0.4,
		"spd": 0.5,
		"def_phys": 1.8,
		"def_spec": 1.2,
		"counter_rate": 1.5, # Tỉ lệ phản đòn
		"block_rate": 1.4 # Tỉ lệ chặn đòn
	},
	CharacterClass.ASSASSIN: {
		"hp": 0.7,
		"mana": 0.6,
		"atk_phys": 1.3,
		"atk_spec": 0.4,
		"spd": 1.8,
		"def_phys": 0.6,
		"def_spec": 0.5,
		"crit_rate": 1.5, # Tỉ lệ chí mạng
		"dodge_rate": 1.3 # Tỉ lệ né tránh
	},
	CharacterClass.MAGE: {
		"hp": 0.6,
		"mana": 1.8,
		"atk_phys": 0.3,
		"atk_spec": 1.7,
		"spd": 0.7,
		"def_phys": 0.4,
		"def_spec": 1.1,
		"magic_pen": 1.4, # Xuyên giáp phép thuật
		"mana_regen": 1.5 # Hồi mana
	},
	CharacterClass.BERSERKER: {
		"hp": 1.2,
		"mana": 0.4,
		"atk_phys": 1.8,
		"atk_spec": 0.3,
		"spd": 0.8,
		"def_phys": 0.9,
		"def_spec": 0.6,
		"rage_bonus": 1.6, # Tăng sát thương khi máu thấp
		"lifesteal": 1.2 # Hút máu
	},
	CharacterClass.PALADIN: {
		"hp": 1.3,
		"mana": 1.0,
		"atk_phys": 0.9,
		"atk_spec": 0.8,
		"spd": 0.6,
		"def_phys": 1.4,
		"def_spec": 1.3,
		"healing": 1.3, # Khả năng hồi phục
		"protect_rate": 1.4 # Khả năng bảo vệ đồng đội
	},
	CharacterClass.RANGER: {
		"hp": 0.8,
		"mana": 0.7,
		"atk_phys": 1.4,
		"atk_spec": 0.6,
		"spd": 1.4,
		"def_phys": 0.7,
		"def_spec": 0.7,
		"range_bonus": 1.5, # Tăng sát thương đánh xa
		"accuracy": 1.4 # Độ chính xác
	},
	CharacterClass.WARLOCK: {
		"hp": 0.7,
		"mana": 1.5,
		"atk_phys": 0.4,
		"atk_spec": 1.5,
		"spd": 0.6,
		"def_phys": 0.5,
		"def_spec": 1.0,
		"dot_power": 1.4, # Sát thương theo thời gian
		"summon_power": 1.5 # Sức mạnh quái vật triệu hồi
	},
	CharacterClass.DRUID: {
		"hp": 1.0,
		"mana": 1.2,
		"atk_phys": 0.8,
		"atk_spec": 1.1,
		"spd": 0.9,
		"def_phys": 1.0,
		"def_spec": 1.0,
		"healing": 1.4, # Khả năng hồi phục
		"form_bonus": 1.3 # Bonus khi biến hình
	},
	CharacterClass.MONK: {
		"hp": 1.0,
		"mana": 0.8,
		"atk_phys": 1.2,
		"atk_spec": 0.7,
		"spd": 1.5,
		"def_phys": 1.0,
		"def_spec": 0.9,
		"dodge_rate": 1.5, # Tỉ lệ né tránh
		"counter_rate": 1.3 # Tỉ lệ phản đòn
	}
}

# Growth curve types
var GROWTH_CURVES = {
	"linear": func(_level: int) -> float: return 1.0 * _level,
	"early_boost": func(_level: int) -> float: return 1.2 * sqrt(_level),
	"late_bloom": func(_level: int) -> float: return 0.8 * pow(_level, 1.2),
	"mid_spike": func(_level: int) -> float: return 1.0 * (1 + sin(PI * _level / 40)),
	"steady": func(_level: int) -> float: return 0.9 * pow(_level, 1.1)
}

# Class-specific growth patterns
const CLASS_GROWTH_PATTERNS = {
	CharacterClass.GUARDIAN: {
		"hp": "late_bloom",
		"mana": "linear",
		"atk_phys": "steady",
		"atk_spec": "linear",
		"spd": "linear",
		"def_phys": "late_bloom",
		"def_spec": "steady"
	},
	CharacterClass.ASSASSIN: {
		"hp": "linear",
		"mana": "linear",
		"atk_phys": "early_boost",
		"atk_spec": "linear",
		"spd": "early_boost",
		"def_phys": "linear",
		"def_spec": "linear"
	},
	CharacterClass.MAGE: {
		"hp": "linear",
		"mana": "late_bloom",
		"atk_phys": "linear",
		"atk_spec": "late_bloom",
		"spd": "linear",
		"def_phys": "linear",
		"def_spec": "steady"
	},
	CharacterClass.BERSERKER: {
		"hp": "steady",
		"mana": "linear",
		"atk_phys": "late_bloom",
		"atk_spec": "linear",
		"spd": "linear",
		"def_phys": "mid_spike",
		"def_spec": "linear"
	},
	CharacterClass.PALADIN: {
		"hp": "late_bloom",
		"mana": "steady",
		"atk_phys": "steady",
		"atk_spec": "steady",
		"spd": "linear",
		"def_phys": "late_bloom",
		"def_spec": "late_bloom"
	},
	CharacterClass.RANGER: {
		"hp": "linear",
		"mana": "linear",
		"atk_phys": "early_boost",
		"atk_spec": "linear",
		"spd": "early_boost",
		"def_phys": "linear",
		"def_spec": "linear"
	},
	CharacterClass.WARLOCK: {
		"hp": "linear",
		"mana": "late_bloom",
		"atk_phys": "linear",
		"atk_spec": "late_bloom",
		"spd": "linear",
		"def_phys": "linear",
		"def_spec": "steady"
	},
	CharacterClass.DRUID: {
		"hp": "steady",
		"mana": "steady",
		"atk_phys": "mid_spike",
		"atk_spec": "mid_spike",
		"spd": "steady",
		"def_phys": "steady",
		"def_spec": "steady"
	},
	CharacterClass.MONK: {
		"hp": "steady",
		"mana": "linear",
		"atk_phys": "early_boost",
		"atk_spec": "linear",
		"spd": "early_boost",
		"def_phys": "steady",
		"def_spec": "steady"
	}
}


# Khởi tạo base stats lần đầu khi người chơi chọn class
func init_base_stats_1st_by_class_player():
	match class_player:
		"Guardian":
			base_hp = 150
			base_mana = 50
			base_atk_phys = 60
			base_atk_spec = 30
			base_spd = 20
			base_def_phys = 100
			base_def_spec = 80
		"Assassin":
			base_hp = 80
			base_mana = 40
			base_atk_phys = 90
			base_atk_spec = 20
			base_spd = 100
			base_def_phys = 40
			base_def_spec = 30
		"Mage":
			base_hp = 60
			base_mana = 120
			base_atk_phys = 20
			base_atk_spec = 100
			base_spd = 40
			base_def_phys = 30
			base_def_spec = 50
		"Berserker":
			base_hp = 120
			base_mana = 30
			base_atk_phys = 120
			base_atk_spec = 20
			base_spd = 50
			base_def_phys = 60
			base_def_spec = 40
		"Paladin":
			base_hp = 100
			base_mana = 80
			base_atk_phys = 70
			base_atk_spec = 50
			base_spd = 40
			base_def_phys = 80
			base_def_spec = 70
		"Ranger":
			base_hp = 90
			base_mana = 60
			base_atk_phys = 80
			base_atk_spec = 40
			base_spd = 90
			base_def_phys = 50
			base_def_spec = 40
		"Warlock":
			base_hp = 70
			base_mana = 110
			base_atk_phys = 30
			base_atk_spec = 90
			base_spd = 30
			base_def_phys = 40
			base_def_spec = 60
		"Druid":
			base_hp = 80
			base_mana = 100
			base_atk_phys = 40
			base_atk_spec = 70
			base_spd = 50
			base_def_phys = 50
			base_def_spec = 70
		"Monk":
			base_hp = 85
			base_mana = 50
			base_atk_phys = 70
			base_atk_spec = 30
			base_spd = 95
			base_def_phys = 60
			base_def_spec = 50

func gain_exp(amount: int):
	exp += amount
	while exp >= exp_to_next_level:
		exp -= exp_to_next_level
		level_up()

func level_up():
	level += 1
	exp_to_next_level = int(exp_to_next_level * 1.5)
	calculate_stats(level)

# Tính toán stats dựa vào class, level,...
# Tính toán từ các giá trị khởi tạo từ hàm int... nên không cần save, mỗi khi run game thì sẽ chạy hàm này 1 lần
func calculate_stats(_level: int):
	# Initialize base stats first
	init_base_stats_1st_by_class_player()
	
	# Get class enum value from string
	var class_enum = CharacterClass[class_player.to_upper()]
	var multipliers = CLASS_MULTIPLIERS[class_enum]
	var growth_pattern = CLASS_GROWTH_PATTERNS[class_enum]
	
	# Calculate stats using base stats, multipliers, growth curves and attributes
	
	# HP calculation
	var hp_growth = GROWTH_CURVES[growth_pattern["hp"]]
	hp = int(base_hp * multipliers["hp"] * hp_growth.call(_level) + (vitality * 10))
	
	# Mana calculation
	var mana_growth = GROWTH_CURVES[growth_pattern["mana"]]
	mana = int(base_mana * multipliers["mana"] * mana_growth.call(_level) + (wisdom * 8))
	
	# Physical Attack calculation
	var atk_phys_growth = GROWTH_CURVES[growth_pattern["atk_phys"]]
	atk_phys = int(base_atk_phys * multipliers["atk_phys"] * atk_phys_growth.call(_level) + (strength * 5))
	
	# Special Attack calculation
	var atk_spec_growth = GROWTH_CURVES[growth_pattern["atk_spec"]]
	atk_spec = int(base_atk_spec * multipliers["atk_spec"] * atk_spec_growth.call(_level) + (intelligence * 5))
	
	# Speed calculation
	var spd_growth = GROWTH_CURVES[growth_pattern["spd"]]
	spd = int(base_spd * multipliers["spd"] * spd_growth.call(_level) + (agility * 3))
	
	# Physical Defense calculation
	var def_phys_growth = GROWTH_CURVES[growth_pattern["def_phys"]]
	def_phys = int(base_def_phys * multipliers["def_phys"] * def_phys_growth.call(_level) + (endurance * 4))
	
	# Special Defense calculation
	var def_spec_growth = GROWTH_CURVES[growth_pattern["def_spec"]]
	def_spec = int(base_def_spec * multipliers["def_spec"] * def_spec_growth.call(_level) + (resistance * 4))
