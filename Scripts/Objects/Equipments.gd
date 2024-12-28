extends Resource

class_name Equipments

@export var name : String
@export var type : String
@export var rank : String # Grey - Green - Blue - Orange - Red - Purple - Black
@export var level : int
@export var description : String
@export var weight : int
@export var stats : Dictionary
@export var effects : Dictionary

const IncreaseHpEffect = preload("res://Scripts/Objects/Effects/IncreaseHpEffect.gd")

func _init(_name = "", _type = "", _description = "", _stats = {}, _effects = {}):
	name = _name
	type = _type
	description = _description
	stats = _stats
	effects = _effects

func apply_equipment_effects(target):
	for effect_name in effects.keys():
		var effect_instance = create_effect_instance(effect_name, effects[effect_name])
		if effect_instance:
			effect_instance.activate(target)

func create_effect_instance(effect_name: String, value: float) -> Effects:
	match  effect_name:
		"IncreaseHpEffect":
			var effect = IncreaseHpEffect.new()
			effect.percentage = value / 100.0
			return effect
		# Thêm các hiệu ứng khác
		_:
			print("Unknown effect:", effect_name)
			return null
		
