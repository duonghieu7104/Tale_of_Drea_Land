extends Resource

class_name Player

@export var hp : int
@export var mana : int
@export var atk_phys : int
@export var atk_spec : int
@export var spd : int
@export var def_phys : int
@export var def_spec : int

@export var vitality: int  # Tăng tiến HP
@export var wisdom: int  # Tăng tiến Mana
@export var strength: int  # Tăng tiến ATK vật lý
@export var intelligence: int  # Tăng tiến ATK phép thuật
@export var agility: int  # Tăng tiến Tốc độ
@export var endurance: int  # Tăng tiến DEF vật lý
@export var resistance: int  # Tăng tiến DEF phép thuật

@export var nature: String

@export var GP : int # Đơn vị tiền GP (Gold Point)

@export var inventory = Inventory.new()

func apply_nature_effects():
	match nature:
		"Lonely":
			atk_phys += 10
			def_phys -= 10
		"Brave":
			atk_phys += 10
			spd -= 10
		"Adamant":
			atk_phys += 10
			atk_spec -= 10
		"Naughty":
			atk_phys += 10
			def_spec -= 10
		"Bold":
			def_phys += 10
			atk_phys -= 10
		"Relaxed":
			def_phys += 10
			spd -= 10
		"Impish":
			def_phys += 10
			atk_spec -= 10
		"Lax":
			def_phys += 10
			def_spec -= 10
		"Timid":
			spd += 10
			atk_phys -= 10
		"Hasty":
			spd += 10
			def_phys -= 10
		"Jolly":
			spd += 10
			atk_spec -= 10
		"Naive":
			spd += 10
			def_spec -= 10
		"Modest":
			atk_spec += 10
			atk_phys -= 10
		"Mild":
			atk_spec += 10
			def_phys -= 10
		"Quiet":
			atk_spec += 10
			spd -= 10
		"Rash":
			atk_spec += 10
			def_spec -= 10
		"Calm":
			def_spec += 10
			atk_phys -= 10
		"Gentle":
			def_spec += 10
			def_phys -= 10
		"Sassy":
			def_spec += 10
			spd -= 10
		"Careful":
			def_spec += 10
			atk_spec -= 10
		_:
			print("Unknown nature:", nature)
