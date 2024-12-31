extends Resource

class_name  PlayerStats

@export var base_hp : int
@export var base_mana : int
@export var base_atk_phys : int
@export var base_atk_spec : int
@export var base_spd : int
@export var base_def_phys : int
@export var base_def_spec : int

@export var vitality: int  # Tăng tiến HP
@export var wisdom: int  # Tăng tiến Mana
@export var strength: int  # Tăng tiến ATK vật lý
@export var intelligence: int  # Tăng tiến ATK phép thuật
@export var agility: int  # Tăng tiến Tốc độ
@export var endurance: int  # Tăng tiến DEF vật lý
@export var resistance: int  # Tăng tiến DEF phép thuật

@export var nature: String

@export var GP : int # Đơn vị tiền GP (Gold Point)

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
