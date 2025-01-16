extends Resource

class_name Effectable

@export var effects: Dictionary

#func apply_item_effects(target):
	#for effect_name in effects.keys():
		#var effect_instance = create_effect_instance(effect_name, effects[effect_name])
		#if effect_instance:
			#effect_instance.activate(target)

#func create_effect_instance(effect_name: String, value: float) -> Effects:
	#match effect_name:
		#"IncreaseHpEffect":
			#var effect = IncreaseHpEffect.new()
			#effect.percentage = value / 100.0
			#return effect
		## Thêm các hiệu ứng khác
		#_:
			#print("Unknown effect:", effect_name)
			#return null
