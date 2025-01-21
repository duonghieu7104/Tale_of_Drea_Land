extends Node

# CharacterBase.gd
class_name CharacterBase

# Các thuộc tính chung cho mọi nhân vật
var level: int = 1
var current_hp: float
var current_mana: float
var experience: int = 0
var is_alive: bool = true

# Các phương thức chung
func take_damage(amount: float):
	current_hp -= amount
	if current_hp <= 0:
		die()

func heal(amount: float):
	pass
	#current_hp = min(current_hp + amount, calculate_stats(level)["hp"])

func die():
	is_alive = false
	# Xử lý khi nhân vật chết

func gain_exp(amount: int):
	experience += amount
	check_level_up()

func check_level_up():
	# Logic level up sẽ được implement sau
	pass
